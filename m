Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73099C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySas-0007uN-3R; Mon, 24 Aug 2026 07:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wySaq-0007rT-4T
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:11:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wySao-0003KM-Hu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:11:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so2725829b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787569912; x=1788174712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xd3N29ucPDdQ04y6/Np/nMQdUe0G5J4exYP1S+Xq1pQ=;
 b=m+BCNa77Rz1Qy1dOH0e0/ENNkN+zJY+GOyfc4SjZZ5z2qjxCkEFjcMnM8nNu2vzYdB
 Aho/mptrFDVzEES0DqQ3FnJyld/+HFF2XgDPFzzVW0S2spMNshaKSmgj2qmnwReQ7cr7
 9Rv3JNfHJCPGVoUQ/5A8UTydgZG+I8ra9RulkbWdSsVeNlPhmAaWWZ5xd5F/A7IAd5a5
 ojZm/qTmOfLdHbpKnoGyS2nk3cDMgps/elzn43ogvStm181sK+FB1cAGNr4niZLvTOpk
 EhwLdbM+QowineAErXwsMIBUPABMismyQhPjU6gFUEqCfP7yRJWgmGrUC8DF8tAiaQRq
 a0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787569912; x=1788174712;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xd3N29ucPDdQ04y6/Np/nMQdUe0G5J4exYP1S+Xq1pQ=;
 b=sj0JJ2QTL0QR63CLBNB06wzxb0Ol8OTmf2lnPlE+fUT0YdT1eQ7jj1bGdCGZFIIy0J
 ULYBS+yNldWkqvF4FZrGlizIwYmraunlR597ONhLUd6cZN08A3diumMIAP80Wuc7LDWT
 ZWuHiDdlG12Mm66kgniPveOmEShIgtBHEsCQgXP+/JSHmq03QpiLm9kYo5plRpYGmIj4
 98oIoJ2JWkjfst3Ni2Dh/B7zcNinJw5L4s3K5TouFyh+1D4h9/O7XUDYYNNQQxpDSNPE
 DLptTc/xkKkdAk8WQJkpUAxSHr3KcmjYcxfXBjS1AnTbaCHWHubKBYOKj0WVUiX6mNYD
 t/3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbJo5jCJ/bbwkZk2mWTc8J7oHUOMtONlOtCtr1RwaLoClj7u859Rk2QXK/GULoq2RcLy0HWxlxSf/Z@nongnu.org
X-Gm-Message-State: AFuF++kddpWRIXlmjTuoTELuWUp1eq4euKVV4TZ57KD08KJj7IOGN8nV
 vcFxyDrj8NnsB13pRE3cSeXauRuSaZP/WwbMhs+c2+epE3ghxf0olsQA
X-Gm-Gg: AR+sD11e8A4c/5/59XjDr8aLUPnjznD4WpLQfpfVzQGE50yaPS7QBLtXI7Zw4CGjGxY
 84I1RDG/9Qzvnbh8TlbBvHKYnQGLqWIckeZEccKWu1KZ+BRS+3TCjmtnrkZsByO5HjgLkR7Xild
 YPrcdC0yf2dy1/r4HjWa1MakitiRzmkjyIhwVRjgCRr2StM6zRjIRqBuCz++RWBxLddd76acJ1z
 7cQIEE8ck0iMMMoDV3QqyH0JTT5R7hPNuJXD4KOq4frZ9hWmCKTxVmoOxDDmTRxtkT6nA6gtkLU
 DsQCefQ/04X8MNxhOzt0cd5fHutkPAFNZvON1oNfcVCKyUv41b238v5woG5E/K722jiea1blM4a
 +H56Ce5eXpM5+LmO/RfP+CCfbDxpfrTYuLwXT1O4DdiDFUAx9fMMw9xRIJCTO8XabmQwSTVl7f4
 Kr8m7zJ9FsbQh05cP5u0X/bn7N2typjzI+t24BicvPF5bwG8I8yOXRSAAAcGTfBv534dtiWFOl4
 q75JoTG51WncUcRl91pW+uQWA==
X-Received: by 2002:a05:6300:6d8c:10b0:3cd:4fa5:1b88 with SMTP id
 adf61e73a8af0-3cd4fa51bcbmr21595735637.0.1787569912462; 
 Mon, 24 Aug 2026 04:11:52 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc19f39d4b5sm630042a12.8.2026.08.24.04.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 04:11:51 -0700 (PDT)
Message-ID: <72b510cb-a3bc-4885-a87a-6c5dcda21f7b@gmail.com>
Date: Mon, 24 Aug 2026 20:11:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/egl: fix qemu_egl_display type
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260820131933.2729240-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260820131933.2729240-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x436.google.com
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

On 2026/08/20 22:19, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> EGLDisplay is already a pointer type (void *), so declaring
> qemu_egl_display as EGLDisplay * makes it void **, which
> doesn't match any of its usages.
> 
> Fixes: 7ced9e9f6da2 ("ui: add egl-helpers")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

