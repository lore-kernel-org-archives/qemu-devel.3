Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00893C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMcH-0000EF-CI; Mon, 29 Jan 2024 03:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcF-0000Dl-MJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:39 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcD-00055O-Qs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:39 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6de2e24ea87so219781b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706515415; x=1707120215;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DlAjA2hWhuZzVzg5DMKXwv7DvDcOG/YKmvXs1AqB1+w=;
 b=v+51pvz6noDK9ymkOdizrEiobr8cKikSjVNMgvMy6wUD9n3Li1dleQ59+c5niP/lap
 DycIhYR/vKkN2sW2zkz86SwYbg5aL3l5VwWjtoWJS1GEBMf3/uu3adlbCoJ0SGzwSaET
 nescMbLJpwCc5gJCs+rYJvg/AESVjIOi/CRXbLJQmuYKH+RyWfyGwtAky75xfLjIaIG1
 qP+tlbBHTF2QMfBV6tcRayGgTjBsvJT1EO8PbGE3vGqnNnV7pPC9hnFy6BdfO66C6cgB
 gI4nxjPBftCZ3yqI7s+qB8WpJp739CxsYcDYCbQhcbBTSuVZfcmHsd9e54jTH+wbooFT
 I+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706515415; x=1707120215;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlAjA2hWhuZzVzg5DMKXwv7DvDcOG/YKmvXs1AqB1+w=;
 b=Sef1A2IMWOqk8sCcct+Sy+sjKQRUsdlUl5boC6rvOHFvUyX1CW0f9lyaAKYZDvCvWf
 qH3jxX1q4ghuy6d+MtdlhvN7TJOWZQr3YwZL26Kh5YJTjJS20f/nicCMBS6noaSSVu+A
 T9y/rIgxfh1yJvdGd5q5RnNkL0O8tjUh5qRhWyi97NtcDn3WrEEwlYLg7Ux/vHn73Vhu
 euu8famFUQGaUHY7APDFrBsGizU8OIRN2W6CVx++Bgm7AXlD0A4fD3yz+5FgnsNUTklg
 nL7u5I7JTy9G/QzDSAW1cFAzqrY2LdV4boO0krhmNCSnZucCLdfAFxZxJjeqQxTQGH88
 MiYw==
X-Gm-Message-State: AOJu0Yx258Hss0xQOYh5WUXHvR6ZEbJrCx6z3depvHyh0L8RzTN2KNfj
 Ckb6/O3TlvRkpBav/BtYVF0RGQ2WcPgStzUCyxFo04HBCHz9m6eFSMytqUjNR3c=
X-Google-Smtp-Source: AGHT+IHxd6Gv1EwLNThuzkVmcYq76dQOx3xAI22YRiEwz+BNo8xwO5jDAYSb6tG4rSAEQ/kKy2of8A==
X-Received: by 2002:a05:6a00:2d89:b0:6dd:db87:1947 with SMTP id
 fb9-20020a056a002d8900b006dddb871947mr2965742pfb.3.1706515415117; 
 Mon, 29 Jan 2024 00:03:35 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 q189-20020a632ac6000000b005cfbe445a85sm5591001pgq.70.2024.01.29.00.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 00:03:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] hw/smbios: Fix option validation
Date: Mon, 29 Jan 2024 17:03:06 +0900
Message-Id: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpbt2UC/2XMyw6CMBCF4Vchs7amLTSCK97DsOhllFlATcc0E
 NJ3t7J1+Z+cfAcwJkKGe3NAwkxMca2hLw342a4vFBRqg5a6k0r3ghdHkYVD41utwk2ZHur5nfB
 J2wk9ptoz8Sem/XSz+q1/RFZCCt9aI7thcBbtGOy+0nb1cYGplPIFwwXVKZ0AAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This fixes qemu_smbios_type8_opts and qemu_smbios_type11_opts to have
list terminators and elements for the type option.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Fixed messages. (Michael Tokarev)
- Link to v1: https://lore.kernel.org/r/20240128-smbios-v1-0-c3a50499baea@daynix.com

---
Akihiko Odaki (2):
      hw/smbios: Fix OEM strings table option validation
      hw/smbios: Fix port connector option validation

 hw/smbios/smbios.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
---
base-commit: f614acb7450282a119d85d759f27eae190476058
change-id: 20240128-smbios-be5c321d7158

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


