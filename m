Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW5nV-0006Sq-8g; Mon, 22 Jul 2024 23:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sW5nU-0006SB-8T
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:02:40 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sW5nS-0004je-Pg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:02:39 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-651da7c1531so47225487b3.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721703757; x=1722308557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsan2mIhFXDMjIKa5YB8trhZeori1JyDvvzQJFrmEmA=;
 b=Mc2T4zN++2Z6Af8g+N+rNjyli6DxHUzxJcHMSWM9sKPozUm1tB/yqZmRKS6Nfd647U
 GrXPcLtTceBOCatVI16gqWzpprnAVZ6Biw8iqKOUStsCDdSrxufdBlVAJp6CJcZULYHu
 UKDTy5Mm7zDfvBRPLz2a18099UvQRyfiKEpQTgR9tBFi5LT9LIHHSeHnNIdb2Q6mfNL1
 axUDCQNlHhPvb4J0qSM6EVD4pzCHcv2wEazVyQcBJre5mh/DyJNDXGuA5iV2x/m/8BeP
 cl5nql6odW1lYCGOPN4UIp6SK35SZGfuleOa/QHHOA8uqU25ozAJBFmj5HL3fWil63fl
 shXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721703757; x=1722308557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xsan2mIhFXDMjIKa5YB8trhZeori1JyDvvzQJFrmEmA=;
 b=LUIl1OdjVhrMso4Reu8C4NvrFmCsnc26pG/sa7wleBJkN4sQYMnk/tmhITXujs/BF/
 KhDpmbnQ4SyxPDLJVofxy9keYu/zpA5DAFJFfMcvuoD0feZ3Vo6RTW/1Qokl5YqOG9CU
 6creQ3oLm1jts2HJaxCHw2l8ExFGDzrpZ+nsu9TT85ROqS5m60q+C7zBUpiGns91DlIe
 OYiL4eC21D6wFSwBfyWMdF9ZiLUKI2OSxPAJUOZx+tUHBlS4lSj/OxJyA8A88O4w4fWD
 gFTS5N2VJ+NVat3bcgLQhgljECQO5Vb5MYVezcTMxdIHXGaCxouXaMb5ViJ5UDcmkGcf
 sVgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJdyxCe1KKYld1I6a4tsT5Ypx9zwkxSk9871Sf3jRxkedIaGBA6E8lPGxX2UZJcnnuC2q40lsOGCn45KrvHDeKGvNG5Y=
X-Gm-Message-State: AOJu0YxsFauUvs+LEFVxUfWGKpime29vJ6hrbTLCXGiGApjencU+rhLW
 CM5AhvINfFLiwThV5mh2icQ5S9ga0KJ+JszMFIT2S9KxNCKVgKG9pLqqVantfYXEq7GOqd0+cy1
 rhNVrCefzSJeX+ixLLvyR7OGbHRA=
X-Google-Smtp-Source: AGHT+IEF1YGyhOvp11myQhlRFWwBbb3391Q9AK5iDDZOENQHt1gosotfqdPKbQkXw25mxLuS/oyXU38N7mHEKA9zabw=
X-Received: by 2002:a05:690c:6603:b0:647:88ba:f91b with SMTP id
 00721157ae682-66ad8bcca33mr123862887b3.11.1721703757446; Mon, 22 Jul 2024
 20:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
 <20240720142902-mutt-send-email-mst@kernel.org>
 <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
In-Reply-To: <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Tue, 23 Jul 2024 11:02:01 +0800
Message-ID: <CALX8JfRC3mnpLweNu+V6L4K+Hr-w_siCEMKwECUBUwBgqXUkRg@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-yw1-x1133.google.com
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

> or devmem2 read the reg:
>
> "devmem2 0xfed90090"
> "/dev/mem opened."
> "Memory mapped at address 0x7f983014f000."
> "Value at address 0xFED90090 (0x7f983014f000): 0x0"

Sorry, correct the devmem2 read value.
"Value at address 0xFED90090 (0x7f983014f000): 0x1DA801"

