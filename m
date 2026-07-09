Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5366C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpOK-0006jJ-AQ; Thu, 09 Jul 2026 10:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com>)
 id 1whpOJ-0006j6-6J; Thu, 09 Jul 2026 10:06:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com>)
 id 1whpOH-00035H-Ow; Thu, 09 Jul 2026 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=XWOFCWanT3vgy/77OAUtUSVZxSHmJMBJsrLqzX8xLdk=; b=f751O
 9isFXJpjw54zqGC5Mfz2bsx+zBuTMH18WGkUbFjcZ2x/eOsvdit3aSgjhNfEhw4pUUfyxAmX/pUTB
 Dn7ZYvJEksNpFJPcPTM1O+HJ5Ozvv/oC8+dU6UJYt2J149ahPBpWwiRjotgcrlc3jDCSM1ty/TLjh
 g4fjhEp6mUIvaVDKmWO57/GPuiuaehWvWdmCGPedIyiEprQKB5zkJZZkrqDmcXAhxEniXW5hkp86P
 LXsZrPfQS91CWRY4IL+rkMSMBRp/w1rmT4XH+wvpyQqg6oDcqAe289+hMH7mi5qYl1mFLnEmV7jMr
 SrqqzNUX5Ivcdz/3tJC8+nqu5ub9oWv8Q64ImxAZrA5pWhmHvloNQ1YKbnzkh/qrfG4q3X48DVOk/
 wP08pQiYgFx50RRUIE9YHsZNu6Y99EMCN6U00clsRBRHaoa3f7VRaY7LpYANeztP6/ZIV3Jd9ZbDS
 vICx25gKo0qY4HEI9w6ticEFaRp0hlo28OqB1afbFtOwuXQSJ5M28Ih6QYsRLDC3eKq7WYJtONgiG
 shvNfTMXxc4hVoUi+hHshJbUKh2FiJGYOSbanHq1RLy8e7Z9sZ9oQAnICai4z30eWS11DjJeH/d+f
 FqCVYArrZ+OHstkF6+Ri7yfBTvovPJUX71zuNoE7tGiNOs9LWzqgS7/UrJ6G/o=;
Message-ID: <cover.1783604079.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jul 15:50:36 +0200
Subject: [PATCH 0/3] 9p: fix guest-triggered Treaddir/ACPI eject UAF
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, INVALID_DATE=1.096,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A guest can trigger unplugging 9pfs server's virtio-pci device via ACPI
eject. As a consequence the device is unrealized, server's internal state
is freed while pending coroutines would still have access to them, causing
a potential heap-use-after-free.

Overview Patches:

 - Patch 1: this is the core fix, that drains all PDUs (i.e. coroutines
   that handle individual pending requests in parallel) before freeing
   server state.

 - Patch 2: hardens security by disabling guest triggered ACPI rejects in
   general for 9pfs's virtio transport.

 - Patch 3: fixes a similar identified issue with the Xen transport, even
   though not triggered via ACPI, it is also prone to UAF, plus a resource
   leak.

Independent of this series, it should be considered to globally change the
default value of devices' hotpluggable property from default enabled, to
default disabled. Because as this issue showed, it should be a conscious
decision of developers to explicitly opt-in when knowing that their device
DOES support hot-unplugging AND that it actually makes sense for the device
category. As changing the default value affects a massive amount of devices
in QEMU, I am still investigating this and this is of course not covered yet
by this series.

Christian Schoenebeck (3):
  hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
  hw/9pfs/virtio: disable hotpluggable property of virtio-9p device
  hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect

 hw/9pfs/virtio-9p-device.c | 2 ++
 hw/9pfs/xen-9p-backend.c   | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.47.3


