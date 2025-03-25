Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C330C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDBC-0003Lu-UX; Tue, 25 Mar 2025 18:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1txDB4-0003Jo-IE
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:55:23 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1txDB1-0008Ob-Q6
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:55:22 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c6f6f75a81so3242085fac.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742943316; x=1743548116;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PfZDCKs3ZZUCUEu3Ht/6snT7EFTNozaP+2Yg92XkYUQ=;
 b=JBNZrLLMZ0z2UJijw1fozHp0wnDNQgDKYGAVfjVmSApQ8Aa3jKaL3uFEYT4RE8K2KS
 wAS2uZzuZsWTB8omsnC/V6UzzROj8kuROe6IRKzrI4Cf0O83+oK2dSpxS3jCpi62cBtt
 LrVHp/1SaQX4Uf5kHlS4TmIC3WFokFo4Eu4phKOm4RBKq8LWw/FoKiCK7VzXtNma0Ojv
 vR4ZBgXeMVoOMQvTmOMydL+TZe9UaDfUK+jK/gGR9Hz+OovnjtD17su029zmjVdb3aZG
 UPoZRAfUqpAzLz05C1/L0sn5UWU2lrm0j+JMZ/Y+2X7XO97Z/bSC2lI26cWi3VijVBgB
 9GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742943316; x=1743548116;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PfZDCKs3ZZUCUEu3Ht/6snT7EFTNozaP+2Yg92XkYUQ=;
 b=U1JY90zCdM03T5DwZjobXsmqm/dlC67RqbTntTa0ob8UYAM87hplPJ/YRrFbOJPUia
 IRBOffjwu/PKvNZmhpWdod+om7FgBGciwTEijf/XFBSxkC3yICgVTDZW5UCjjJD+aFik
 krfHXAWmSr2KpWdCQVRh30jhO1kQpfL/y+R3f71mdxqicyjwKBtQ+Z7IIwbWhiPoMdKg
 i+L0slYz2FSTIoxzMHQDXbPiu+PJLiIyNO4et0oZsPZMegMerd/Soc6tAcew/shRwwV9
 Kvf10HL1UylCBwFqsQ0hBDTQejowRopeNz46HAxg8czEX7m3c0iggXl9JbnwzRQdAsjO
 CG7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj9CAy1lIvcw/SVccilG5gxqWtxuPPpFq6Is9xikdKOs9KuYIrA7amImoCtkY0wEJAK+QCc1K69xPq@nongnu.org
X-Gm-Message-State: AOJu0YwgKgu1m3odU0UbY/oILZUt7h8VeVvbXne/FvLM5oObWo44NxoO
 xMiYr4GwN+kGxFpKeDPKlL0GSY+GHb59r6OWR6llzX3vQv9WBCW2w22hdlE+ihs=
X-Gm-Gg: ASbGncuE2oIhBsyaaLWk8wJSdBwstkQ5maORNkrCHLTSamRF4yPdnV7xnf+U0fIIbpi
 PielrN+qZhdYar4DOIJg5n6M3g7t4IUhc+RzbqXRg++A+Caagf7bii2CiVK0ZbngVpCOyS3LVdw
 gNnSdpivwTRBP2cZXSWDe8m8p0OFO8srN27JBvFuIGGqKO0ywxu6VKA2VCoQAaP+PQtmVN2Uv60
 ng4rSEpCdX/UYnSNofeJPUeTTeSeU1pJyn5f3WhhBpXlOiL0qUVsACvUDM+vrveHrWRbQPjsC0x
 DWjWphsAc9WKJDhbhx8jZcsHL8UFVQm+dXeijeI47UawaUE/
X-Google-Smtp-Source: AGHT+IF1wlCPAMuXOBSAMgEfiUi8a94TPyK5fyROqMZ2Yo7o8YLFZyGyHK+96Jyh2JIYuTQ0EoJvCA==
X-Received: by 2002:a05:6870:a112:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2c78054b065mr12483637fac.36.1742943315624; 
 Tue, 25 Mar 2025 15:55:15 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:7eec:65ba:af63:5029])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77ecda836sm2728604fac.25.2025.03.25.15.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:55:14 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:55:07 -0500
From: Corey Minyard <corey@minyard.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-block@nongnu.org,
 Patrick Leis <venture@google.com>, David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-10.0 06/12] hw/i2c/pca954x: Categorize and add
 description
Message-ID: <Z-M0SzZFk1yihEi0@mail.minyard.net>
References: <20250325224310.8785-1-philmd@linaro.org>
 <20250325224310.8785-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325224310.8785-7-philmd@linaro.org>
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=corey@minyard.net; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 25, 2025 at 11:43:04PM +0100, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i2c/i2c_mux_pca954x.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Looks ok to me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index 779cc4e66ed..100b8d86093 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -175,12 +175,18 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
>  static void pca9546_class_init(ObjectClass *klass, void *data)
>  {
>      Pca954xClass *s = PCA954X_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "PCA9546 I2C multiplexer";
>      s->nchans = PCA9546_CHANNEL_COUNT;
>  }
>  
>  static void pca9548_class_init(ObjectClass *klass, void *data)
>  {
>      Pca954xClass *s = PCA954X_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "PCA9548 I2C multiplexer";
>      s->nchans = PCA9548_CHANNEL_COUNT;
>  }
>  
> @@ -226,13 +232,13 @@ static void pca954x_class_init(ObjectClass *klass, void *data)
>  
>      rc->phases.enter = pca954x_enter_reset;
>  
> -    dc->desc = "Pca954x i2c-mux";
>      dc->realize = pca954x_realize;
>  
>      k->write_data = pca954x_write_data;
>      k->receive_byte = pca954x_read_byte;
>  
>      device_class_set_props(dc, pca954x_props);
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>  
>  static const TypeInfo pca954x_info[] = {
> -- 
> 2.47.1
> 
> 

