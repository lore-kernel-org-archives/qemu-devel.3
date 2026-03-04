Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BABEDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbPf-00062c-Am; Tue, 03 Mar 2026 20:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPa-00061d-8h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:31 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPY-0004TP-W4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:30 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-5ff14dd9be4so4433832137.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772589147; x=1773193947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ079vS7A/A4BZyc3h4DSpRr2ArVx5hvIslaT33EcVI=;
 b=MA6V6VZ/PU3cdLzgysvtO75CSyAyoBfdLx/eDSWuLcAEbWe7sEsSazuB4JG0mJsNtX
 HWI1up2ppff3L6BTGhVESYhmiH+9HezsDY8OafUWM3jRBsCnNX4pM2LHl4hDGIVklrhk
 16Li9nYYqUe0nFzMPJJ8cPhsB7lcmCarpUr2b/+tOLP/pchpGkkK/Obubw1o+Mf/EAs3
 Rdpy0cxfHTh0/fJBhdYrinqI9XJoBNXSy40gxhJ/o6qSF4aLlyGyGp6bwLgItJZEJheG
 vmlSqPXbGPb1t4SEhdw6EGXqGWbYBl3zEEAXDdreDFU56AZ/vhfEoWrkcb9bP/SZKwVO
 EGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589147; x=1773193947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZ079vS7A/A4BZyc3h4DSpRr2ArVx5hvIslaT33EcVI=;
 b=DZGXd6RzN0sv1IaHTatwgaUDN1/wBu2SCFqgCU6BMwomjiV6FbOiju/YwCCr2UzUel
 b+rjsK6mzvaPzInwx2cqrkj9GrZwiQ0QQMfeuQlH6Oic4n1UKS62ZB9Lww8l/lxZN1j7
 m4igJKUs9pmxiCg76PB6b+VuBjVJNRVEHnM5xlWIS+yShqnbSb9cx9Ist+8FmyKDiPkk
 q4LOQybdeUKh673EFlRXFnDohHHH5YsugmNf8FS/rOGs7rABXFAyJBXJ9bv6pGEr712q
 Oz399tcA/JxzCiiIzhY6IUEdXOA1I4o/yogYzRctP6OqrW5PqRkJx6ReTMJxTCnghLX8
 pP6A==
X-Gm-Message-State: AOJu0Yx466MQ1Mh/ouvI+H+L5NOTg8Q485PJbQ7D0+VwyN5hKBIzxbE1
 iV5BaZWwWwAFVwkfgi42n59Lfl+7OBGO2WbgItFUFfch0ECL9OZtBpodQDMzGXJn
X-Gm-Gg: ATEYQzz3YHsVJRPVVHvADph2mUWD+UKomphZJx73JrsDWLPayg5wMzZEGyfkp/XbF/K
 LtU+s/szUqaWV6TzMpHH3lvQfUittLCnzZFzNgqBm+BDtp3xHpR2GQggeT2YamR7n6PW8Zw4puh
 7sCF5WQ6VHSrmWGRr9uKFRTP+bswWXpnuWlVVmHd32PpNOtoeKV+z0nrfbYxgzvYOQPwJnr928/
 BQXEqodcw64eZ1GtuS7EXhctw3U+7ZcsQgoZsYRDM3kpnI09eZwjXo2ph5I1oXBPc1am8rRtx28
 1L3VrDKQHb8vVI8mI387ZU9KCn3bEhP4YGiOCeoemTzzjQ+a/RHuZzHxwOYghBLs0BGBmzjn0Mj
 mCCbirVARSHLh+Vd47wzdb1iVW5a7qdllCunTlE7W/mnqHdhdb36XSZiiqqZZoSW+GMU91IjO33
 BUlLw48uE1H+0wS3Fy6XkAo9JqgBbx2iVw+fY6hNX/oVq389EaUEsfPeb/SA==
X-Received: by 2002:a05:6102:f10:b0:5f7:307e:80d9 with SMTP id
 ada2fe7eead31-5ffaafc647dmr351581137.28.1772589146690; 
 Tue, 03 Mar 2026 17:52:26 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ffaca9c848sm303553137.10.2026.03.03.17.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 17:52:26 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/5] xen: pvh: Add machine option to disable the mapcache
Date: Wed,  4 Mar 2026 02:52:16 +0100
Message-ID: <20260304015222.979224-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This adds a mapcache option to the PVH machines allowing users to disable the
mapcache. To remain backwards compatible, the option defaults to "on".

When disabled, all guest memory is mapped at startup rather than on demand.
Starting QEMU may take longer in this mode, but runtime overhead is reduced and
it also enables virtio vhost backends to work.

As a trade-off, grants are unavailable without the mapcache and guests with
large amounts of RAM can take quite a while to start.

Cheers,
Edgar
 
Edgar E. Iglesias (5):
  xen: mapcache: Assert mapcache existance
  xen: mapcache: Add function to check if the mapcache is enabled
  physmem: xen: Conditionalize use of the mapcache
  hw/xen-hvm: Add a mapcache arg to xen_register_ioreq()
  hw/xen: xenpvh: Add prop to enable/disable the mapcache

 hw/i386/xen/xen-hvm.c           |   2 +-
 hw/xen/xen-hvm-common.c         |  18 +++--
 hw/xen/xen-mapcache.c           |  16 ++++
 hw/xen/xen-pvh-common.c         | 134 +++++++++++++++++++++++++++++---
 hw/xen/xen_stubs.c              |   5 ++
 include/hw/xen/xen-hvm-common.h |   3 +-
 include/hw/xen/xen-pvh-common.h |   2 +
 include/system/xen-mapcache.h   |   1 +
 system/physmem.c                |  13 ++--
 9 files changed, 169 insertions(+), 25 deletions(-)

-- 
2.43.0


