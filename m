Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFC5C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CRn-0006Ov-38; Thu, 03 Sep 2026 14:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRj-0006N4-7n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRc-0005jD-U4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so167150f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788461145; x=1789065945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L3nlHceLMeRvdDQ35xaQ6jNOZmBQAWYtUnidtYJezrQ=;
 b=Ade0dJRfExT9q+NQO0Z/yo6l/b05bSDe10Tk6M4D/7MwGIX8scYF4gR93xvgJUngk6
 8pa0H2ydyNxS3Eiy4daJIFC3UUhPPsAa/tpjOWh1gttZ4hyxfjxeDD8F2SBR7VDlAVDN
 EtQTzyTYvU9G1tuMcIBWICNI+nO+6dAcUyj6HnUKqhpoTdSNQuwBfVC6ZHXDOQuWU+UA
 D0vp8vxLtoOBqVe2B626dX1M35cfxgqkBeCH1IwK6E5qigMlMzLyLYH0gjWDHrYEnBcp
 pWudts3WjXEuwOB7t1GZgt4r0+TWt2blZKIoP101To4wtuqGEe5LCvQXJ00MNARuSR9Y
 5oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461145; x=1789065945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L3nlHceLMeRvdDQ35xaQ6jNOZmBQAWYtUnidtYJezrQ=;
 b=YLVLs7BOV4Og/87CZkvxtmpFA+TNjYlOKfMM75x7jfzuo3TJKEFxRCr6/f7kOTol9r
 3L8QR8Ad4Tzkbn4xkZVZgTAwqjkQLAMPRP4tjDq1wQFTyYAYcJCJkUrTBZuL0YTs1poW
 lywxMckRLYgY4PCU5eNM12xybMe2MVR+9emBvB2yp+8ps6EoH1jSRGSDM0Xkx5Pz2hTX
 Lp7mGAoJpyIDLMltTKGNMftF+dcBXB0vp7FnauLeRok088jg1bSXvrpw7RSkCWNY1cI9
 ePkg/TGdK6/lZ6jSdmLkzWitYX5RiHx/XK0VHjxTiCoqLTKhlQWXyIZliRyb+8ssdjn2
 w0GA==
X-Gm-Message-State: AFuF++lzDiLJuxACZCxZ9E4ujlg5n7t6BC8KtsHHdpXbK+HUPd3HJ171
 FYImt9YWdwwXv3lGpZRNAalMcGNFsAAhd2j/3I7ujq3hitEVmZXTmnUsHhUka4dLMedZW6e8JDW
 n10dI
X-Gm-Gg: AYBFou1YzHzPj86UY/z7aRMBuMzurEsRjZV4p2O+wsZLhE7qKhdmxOhFzgVoxzjISkb
 4FcUxDpI9x8ODHORjKcpf9ivi7E0Va8DLIvWBj13s1zuN+2cHXynvFbMzt0hvXgRbqJpvgx/p5a
 ebP6k4ePUMORpMSn7yPABDd4qmoK8uJcFww9jkK2ZWenP+cL4xj5oPQixXHNFDLNM8KyLgR7xfn
 c+IuJGD+8lqLOlFn2kZPNNKUGZvYunhiLt+Cj+LJJDlc6cIMQ8tyGu21BZpX7ohRucKHb/9UJBr
 WXnDB00G5I8J65mX+cjt35W4aJEf0m1idePNYt5dQQSIk8FvtNLa3bnwCOv3nGjcxp1DTMMUCkt
 wgxNPWgu4fV2Eox9XtKBqT35/RgiukxPHsXbQxFzo4+t+hMSJwC8e6I7Mb9vEXMhkSdJ7tN8qGo
 S9ZMCJxOBOJwlkA50MAZt1/TbFPS2t9JqUZvTWgim/uelvK88l9oNKtopI
X-Received: by 2002:a05:6000:46c8:b0:484:3732:c261 with SMTP id
 ffacd0b85a97d-4858729b9b8mr1773955f8f.17.1788461145380; 
 Thu, 03 Sep 2026 11:45:45 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm395557f8f.13.2026.09.03.11.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:45:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 0/2] pci: batch memory transactions around mapping updates
Date: Thu,  3 Sep 2026 20:45:40 +0200
Message-ID: <20260903184542.2629976-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=den@openvz.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Restoring a PCI device's config space remaps its BARs, updates the bridge
windows when it is a bridge, and toggles the bus master region. Each of
those ends a memory transaction of its own, and a transaction commit
re-renders the flatviews it touches, at a cost which grows with the number
of memory regions in the machine.

So a machine with a rich PCIe topology pays that render many times over
while an incoming migration stream is read, once or more per device, even
though nothing between the steps looks at an address space.

Both patches wrap an existing sequence in a single transaction. There is
no new API and no behaviour a guest can observe: each transaction opens and
closes inside the function that starts it, so nothing sees an intermediate
state which was not already reachable. pci_bridge_update_mappings() has
worked this way for the bridge windows for a long time; the first patch
just makes pci_update_mappings() consistent with it.

Measured on a Windows Server 2022 guest with 64 vCPUs and 65 pcie-root-ports,
the non-iterable part of an incoming migration drops by about a third. The
saving scales with the number of PCI devices, so it is small for a plain
machine and large for the topologies which hurt today.

Note that pci_update_mappings() is also reached from the runtime config
write path, not only from migration. Several BAR moves in one config write
now share a rebuild instead of taking one each, which is the same win in
miniature and equally invisible to the guest.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>

Denis V. Lunev (2):
  pci: batch BAR remapping into one memory transaction
  pci: load a device's config inside one memory transaction

 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.53.0


