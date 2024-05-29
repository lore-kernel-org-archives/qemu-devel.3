Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA102C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM5X-0000C4-TX; Wed, 29 May 2024 12:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM5S-0000Al-5f
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:23:38 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM5K-0005xM-2v
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:23:37 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM5C-006CAe-9t;
 Wed, 29 May 2024 17:23:22 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com
Subject: [RFC v6 00/26] vfio-user client
Date: Wed, 29 May 2024 17:22:53 +0100
Message-Id: <20240529162319.1476680-1-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

This is the 6th revision of the vfio-user client implementation.

First of all, thank you for your time reviewing the previous versions.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been lightly tested against libvfio-user test servers as well as SPDK.

Contributors:

John G Johnson <john.g.johnson@oracle.com>
John Levon <john.levon@nutanix.com>
Thanos Makatos <thanos.makatos@nutanix.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>

Changes from v5->v6:

 - various generic changes split out from vfio-user specific patches
 - full refactoring of vfio-user PCI implementation on top of new
   VFIOUserContainer
 - lots of minor code improvements

Changes from v4->v5:

  vfio-user: introduce vfio-user protocol specification
    Removed VFIO v1 migration support - it will be added back when v2 goes upstream
    Fixed typos

  vfio-user: add VFIO base abstract class
  vfio-user: add container IO ops vector
    No v5 specific changes

  vfio-user: add region cache
    Deleted spurious g_free() calls

  vfio-user: add device IO ops vector
  vfio-user: Define type vfio_user_pci_dev_info
  vfio-user: connect vfio proxy to remote server
    No v5 specific changes

  vfio-user: define socket receive functions
    Handle partial reads of server messages

  vfio-user: define socket send functions
    No v5 specific changes

  vfio-user: get device info
    Return an error if the device reply has an inordinate number of regions or IRQs

  vfio-user: get region info
  vfio-user: region read/write
  vfio-user: pci_user_realize PCI setup
  vfio-user: get and set IRQs
  vfio-user: proxy container connect/disconnect
  vfio-user: dma map/unmap operations
  vfio-user: secure DMA support
  vfio-user: dma read/write operations
  vfio-user: pci reset
    No v5 specific changes

Added to v5:

  vfio-user: forward msix BAR accesses to server
  vfio-user: add 'x-msg-timeout' option that specifies msg wait times
  vfio-user: add tracing to send/recv paths
  vfio-user: add dirty_bitmap stub until it support migration

Removed from v5:

  vfio-user: migration support
  Only set qemu file error if saving state if the file exists


Changes from v3->v4:

 vfio-user: introduce vfio-user protocol specification
   No v4 specific changess

 vfio-user: add VFIO base abstract class
   Put all properties except those specific to the ioctl() implementation in the base class 

 vfio-user: add container IO ops vector
   Move will_commit support to dma map/unmap patch below
   Use ternary return expression in IO ops vectors

 vfio-user: add region cache
   New patch with only region cache support
   Make vfio_get_region_info return region reference instead of a copy

 vfio-user: add device IO ops vector
   Move posted write support to region read/write patch below
   Move FD receiving code to get region info patch below
   Add VDEV_CONFIG_READ/WRITE macros to pci.c for convenient access to PCI config space
   Use ternary return expression in IO ops vectors

 vfio-user: Define type vfio_user_pci_dev_info
   Move secure DMA support to separate patch below
   Remove dummy function for vfio_hot_reset_multi ops vector
   Add vfio_user_instance_finalize code from connect proxy patch below

 vfio-user: connect vfio proxy to remote server
   Move vfio_user_instance_finalize code to define type patch above

 vfio-user: define socket receive functions
   Handle kernel splitting message from server into multiple read()s
   Fix incoming message queue handling in vfio_user_request()
   Move secure DMA support to separate patch below
   Move MAX_FDS and MAX_XFER defines to socket send patch below

 vfio-user: define socket send functions
   Free pending messages when the reply times out
   Add MAX_FDS and MAX_XFER defines from socket recv patch above
   Don't set error twice on a capabilities parsing error

 vfio-user: get device info
   Add vfio_get_all_regions() call
   Validate device info return values from server

 vfio-user: get region info
   Add FD receiving code from device IO ops patch above
   Add a generic FD to VFIORegion for mapping device regions
   Validate region info return values from server

 vfio-user: region read/write
   Add posted write support from device IO ops patch above
   Check region read/write count against max_xfer

 vfio-user: pci_user_realize PCI setup
    Refactor realize functions to use common setup functions

 vfio-user: get and set IRQs
   Validate irq return values from server

 vfio-user: proxy container connect/disconnect
   No v4 specific changes

 vfio-user: dma map/unmap operations
   Add wlll_commit support from container IO ops patch above
   Rename will_commit to async_ops to describe its operation better
   Pass memory region to dma_map op so only vfio-user needs to look up FD
   Free pending messages when the reply times out
   Move secure DMA support to separate patch below
   Set argz in dma_unmap message according to spec

 vfio-user: secure DMA support
   New patch consolidating all secure DMA support

 vfio-user: dma read/write operations
 vfio-user: pci reset
   No v4 specific changes

 vfio-user: migration support
   Move qemu file errors fix to its own patch below
   Set argz in get_dirty_bitmap message according to spec

 Only set qemu file error if saving state if the file exists
   New patch with just this fix found during vfio-user development

Removed from v4:

 Add validation ops vector
   Generic checking moved to the corresponding vfio-user function


Changes from v2->v3:

  vfio-user: introduce vfio-user protocol specification
    Spec specifies host endiannes instead of always LE
    Fixed grammar error

  vfio-user: add VFIO base abstract class
    Moved common vfio pci cli options to base class

  Add container IO ops vector
    Added ops vectors to decide to use ioctl() or socket implementation

  Add device IO ops vector
    Added ops vectors to decide to use ioctl() or socket implementation

  Add validation ops vector
    Added validation vector to check user replies

  vfio-user: Define type vfio_user_pci_dev_info
    Added separate VFIO_USER_PCI config element to control whether vfio-user is compiled
    Fix scalar spelling

  vfio-user: connect vfio proxy to remote server
    Made socket IO non-blocking
    Use g_strdup_printf to save socket name

  vfio-user: define socket receive functions
    Made socket IO non-blocking
    Process inbound commands in main loop thread to avoid BQL interactions with recv
    Added comment describing inbound command callback usage
    Use true/false instead of 1/0 for booleans

  vfio-user: define socket send functions
    Made socket IO non-blocking
    Added version string NULL termination check

  vfio-user: get device info
    Added ops vectors to decide to use ioctl() or socket implementation
    Added validation vector to check user replies

  vfio-user: get region info
    Added ops vectors to decide to use ioctl() or socket implementation
    Added validation vector to check user replies
    Remove merge bug that filled region cache twice

  vfio-user: region read/write
    Added ops vectors to decide to use ioctl() or socket implementation
    Added validation vector to check user replies
    Made posted write conditional on region not mapped

  vfio-user: pci_user_realize PCI setup
    Moved common vfio pci cli options to base class

  vfio-user: get and set IRQs
    Added ops vectors to decide to use ioctl() or socket implementation
    Added validation vector to check user replies
    Fixed %m usage when not using syscall

  vfio-user: proxy container connect/disconnect
    Added separate VFIO_USER_PCI config element to control whether vfio-user is compiled
    Use true/false instead of 1/0 for booleans

  vfio-user: dma map/unmap operations
    Added ops vectors to decide to use ioctl() or socket implementation
    Use BQL instead of iolock in comments
    Fixed %m usage when not using syscall

  vfio-user: dma read/write operations
    Added header checking before loading DMA message content
    Added error handling if DMA fails

  vfio-user: pci reset
    no r3-specific changes

  vfio-user: migration support
    generic fix: only set qemu file error if there is a file


