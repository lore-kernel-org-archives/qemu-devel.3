Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D591E6C610
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 07:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXwqL-0006g0-Az; Tue, 23 Dec 2025 02:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=445b29e9a=Moritz.Haase@bmw.de>)
 id 1vXwqI-0006fc-Ag
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 02:30:02 -0500
Received: from esa13.hc324-48.eu.iphmx.com ([207.54.72.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=445b29e9a=Moritz.Haase@bmw.de>)
 id 1vXwqF-0000Km-QD
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 02:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
 t=1766474999; x=1798010999;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QXsXVScF2JkeKh0MHEMlURpnMBcBRK7NfOf1QO0FmJw=;
 b=SHLrDJmv/av8IYX9Dul0pDh4XGFQloEJHVDiBTDBWUF5kjKirXYihN9+
 4IEFFEUEsOzle88OI6fQPEdPJf194F24UDy3lj+vaQWeaKaYj7OUjci1n
 XweskGfqeIkueOR55WFB4CKyQQOg9XEM1yfmXHd6gyl5+s6ipn0kfkW/t U=;
X-CSE-ConnectionGUID: VKWiuHeRTWSecrGkU/j6Fw==
X-CSE-MsgGUID: mN+GTTtjR/+qaPhHhKmOrQ==
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Dec 2025 08:29:54 +0100
Received: from unknown (HELO esabb5.muc) ([10.31.187.136]) by esagw1.muc with
 ESMTP/TLS; 23 Dec 2025 08:29:54 +0100
Received: from smucmp15h.bmwgroup.net (HELO smucmp15h.europe.bmw.corp)
 ([10.30.13.142]) by esabb5.muc with ESMTP/TLS; 23 Dec 2025 08:29:54 +0100
Received: from smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) by
 smucmp15h.europe.bmw.corp (2a03:1e80:a15:58f::1:4f) with Microsoft SMTP
 Server (version=TLS; Tue, 23 Dec 2025 08:29:53 +0100
Received: from q1054628.de-cci.bmwgroup.net (10.30.85.206) by
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) with Microsoft SMTP
 Server (version=TLS; Tue, 23 Dec 2025 08:29:53 +0100
X-CSE-ConnectionGUID: uH+oXdNaT62Ej5iw0OEhAA==
X-CSE-MsgGUID: 9ax/PtPEQkaOkr/lP6ba8A==
X-CSE-ConnectionGUID: 0Kktmt4QSY+u2XkC31kY2A==
X-CSE-MsgGUID: De5N9nbtSku6OQeRNMri6g==
From: Moritz Haase <Moritz.Haase@bmw.de>
To: <moritz.haase@bmw.de>
CC: <berrange@redhat.com>, <forumi0721@gmail.com>, <laurent@vivier.eu>,
 <mjt@tls.msk.ru>, <nghiant2710@gmail.com>, <petrosagg@resin.io>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5] linux-user: add option to intercept execve() syscalls
Date: Tue, 23 Dec 2025 08:28:36 +0100
Message-ID: <20251223072835.850855-2-Moritz.Haase@bmw.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128090132.2977069-1-Moritz.Haase@bmw.de>
References: <20251128090132.2977069-1-Moritz.Haase@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15c.europe.bmw.corp (2a03:1e80:a15:58f::1:49) To
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44)
Received-SPF: pass client-ip=207.54.72.35;
 envelope-from=prvs=445b29e9a=Moritz.Haase@bmw.de;
 helo=esa13.hc324-48.eu.iphmx.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

https://lore.kernel.org/qemu-devel/20251128090132.2977069-1-Moritz.Haase@bmw.de/

Regards,

Moritz

