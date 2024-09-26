Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0412BCCFA17
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgKz-0007Zm-51; Thu, 26 Sep 2024 00:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgKv-0007YX-QP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:42:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgKt-0001Eq-5d
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:42:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cccbae21fso333204f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727325757; x=1727930557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BN2ApyIuXeyU31g5un8bnUkd5T7xTh4ECfzXWPYb6OA=;
 b=GAi1OAqK3x3qsCJ2erVTH85fGWnNbQItTn5Pqbp3jZTE2s0iangdIO/Lug5p57Xjj2
 lk83UV+CIlC0H4ih2JMXuwQD5T6MMi06ZxKC6LXOPgE9FhbRpzCo6eB8TveeT6sW3t/1
 YQ1eSLacfJJ6lcGcXaOfw7vmviagHa18g24ssthjgYcFRrLAATSYu9jxRz+99x74lcfS
 sDqXo0mR9nh3WkvZ7xTjbzVo7FFvHnzXV9xirIISqIRipHwN0DFNaKG9S2Q9CgisZ75D
 I3U4at47Ng4uJN6LyWOMzQKI4S8nr9BRAyoUGO/PTPZx/eBFtnPF6FqZA1UiZO6JEwD1
 VTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727325757; x=1727930557;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BN2ApyIuXeyU31g5un8bnUkd5T7xTh4ECfzXWPYb6OA=;
 b=Oi2Y+woDntWiB3RTw4Ugz8rMnlmq5m8jGxaxdWANceukWqsTqtqp1dr/7NJyOZzqGA
 zL74N6DCEKFQIfAUMX7zKQZ3COtFsYWFHmhsO9bJDP3Qbyx4cqCckWdo3WkczNrDpIRZ
 3DmNqO2Yix++HimpWi4nHtjv3t1pVa+kC44q0X9S1giwHid23acc6CR/DhMLS178502p
 cJZn8wwJ63l4vkRoRKHLDTmqw1hxvPqZK+DYMBKbAdTEaqomw/mp1/X8mus7qMbRu/iU
 KR6RBwqvjDEebB/A9CDCTD6CXzu6pB72z8IQ36jfp3D3cZPl75irdWJUvzKI5fy5spKe
 TTbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDyRWxfb8lzyL6ihNApolC2CbSEmgoIyRoTRBngqFWs8PEtt1DGHXrtu4znWWpQVya3E0XOcOMmWjI@nongnu.org
X-Gm-Message-State: AOJu0Yy1M2GcL2NHQeCi0qo7Wot+GPerhGI6E7WqDphEWp0h8GZ83l6R
 erl3LZrPKRIavfbRdSeZftXMI4CPHSaqgZzR3UmeNYwsBHuJNzfMaDF7eBMEXVY=
X-Google-Smtp-Source: AGHT+IFelDk92uuFT9zDgjLKeZFziVvZl8knRApOKE8vwBgYfTasLFUU8LfapUVUsEBcj6uScnPMpg==
X-Received: by 2002:adf:f310:0:b0:371:8f32:557e with SMTP id
 ffacd0b85a97d-37cc24c5aa8mr2852787f8f.39.1727325757472; 
 Wed, 25 Sep 2024 21:42:37 -0700 (PDT)
Received: from meli-email.org (adsl-109.109.242.225.tellas.gr.
 [109.242.225.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd10430d6sm207465f8f.81.2024.09.25.21.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:42:37 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:40:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Hyman Huang <yong.huang@smartx.com>, Klaus Jensen <its@irrelevant.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9_?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9_rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 03/22] hw/qxl: fix -Werror=maybe-uninitialized
 false-positives
User-Agent: meli 0.8.7
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-4-marcandre.lureau@redhat.com>
Message-ID: <kel30.5h9ipyhxzs7i@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 24 Sep 2024 16:05, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../hw/display/qxl.c:1352:5: error: ‘pci_region’ may be used uninitialized [-Werror=maybe-uninitialized]
>../hw/display/qxl.c:1365:22: error: ‘pci_start’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> hw/display/qxl.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/display/qxl.c b/hw/display/qxl.c
>index 3c2b5182ca..20e13ee98d 100644
>--- a/hw/display/qxl.c
>+++ b/hw/display/qxl.c
>@@ -1301,8 +1301,8 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
>     };
>     uint64_t guest_start;
>     uint64_t guest_end;
>-    int pci_region;
>-    pcibus_t pci_start;
>+    int pci_region = -1;
>+    pcibus_t pci_start = -1;

Suggestion:

-    pcibus_t pci_start;
+    pcibus_t pci_start = PCI_BAR_UNMAPPED;

Either way,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>     pcibus_t pci_end;
>     MemoryRegion *mr;
>     intptr_t virt_start;
>-- 
>2.45.2.827.g557ae147e6
>
>

