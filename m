Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F204EB3624
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7UT-0002hL-Vk; Mon, 02 Mar 2026 12:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7UK-0002fU-EJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7UG-00058R-3b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772474118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4gQk8QecJuRa1tkH06kVi6OX9PtCJJH23dwgKUWPyQ=;
 b=c8hHjq9cgyBdwUy9yYTJfRv9Fu9VXO5asXv7/VUd34gY26QER33tgF7RRlEWe93bchMrz4
 iew3Li0ZDFyO7JJEl6L4J/lB7oGDjFHN3fMNmRhbvpstYdnOtaiWDC96LgQ+ziU8xfmiOO
 MFH6ZnP98m9FHApE0V1Iodv0XLW7PAw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-o6ffIp2sNIGaxsJizLx7ng-1; Mon, 02 Mar 2026 12:55:17 -0500
X-MC-Unique: o6ffIp2sNIGaxsJizLx7ng-1
X-Mimecast-MFC-AGG-ID: o6ffIp2sNIGaxsJizLx7ng_1772474116
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4363333c102so3225747f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474116; x=1773078916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4gQk8QecJuRa1tkH06kVi6OX9PtCJJH23dwgKUWPyQ=;
 b=f+VTXAI5oZWSZIUzSIItGhGssuaF2trSImN6KftLF8KJgd+IKWtHGhzpj+/pSiCfEN
 XljIaG60LLqmGrs0n1Kajmvu/gLb+7rgkQ5nmkCIOcLl4yq4YFt8dtnFrgXoJeVg53xm
 DYgV2VccJlIstJFbdXBupNNQb+jg7hl+WnB/FEsXqoQTgrChXwDfypJ6cNG2kytRCPbM
 6hLtv9xeJIZrXDV4GK6x0Eilsd+NrIdHMiWQHJWCoS5sVDiLGo8M3H9nuyJmvYPcJoLI
 Ge5amjTaDpsLe8UZWEYfgQSnUaAtQ9LUEjadyt2CwZXi5rSxnudqtr4NvElRs41w0Wu2
 IoNQ==
X-Gm-Message-State: AOJu0YyuAwycBpqnHfnPjfZd0oXqU6Yi3ff3jdCbks/2aKsf0gg9MUag
 SCodUuE7mnBkbidMvOQIbnqtl1ltWJsHo1BE+Rh+xKfz8oZrtG78tNYy55t7wNtveK7CEQsr8jB
 irUORQg1tJnLSbbuYZTfCBCst3+wwjjyRze1nST7ybHNnc+W0quKTMRRo
X-Gm-Gg: ATEYQzwAwVdSCTg0rt+eOAtq8g0qz91Fjo98kxtI7UOJlSNzhLZ9XlAnnSyGj1gTwXw
 w/1ptvNlU5Y6jd609720udvVq2FEVp9TRpfzXda012brTLiI38dCex0YIMfUaG39gh9mEkLCGLp
 jWtv3KIPrOMiAGm80q5iG5ju2jZrvJts7Xl8d90sqTz9L64PN/kQojYFgoAqggLWOJ0siNPxpQv
 bAKX0DI4bXo6ql3dwTWMb4NS2Q1Tf8sBOkUT9nwvJf8gGygmPc2jUxYzmwJ4BgpPgueTKRjx1Fk
 gIqAlj+1DT9j5XTErr2rHEZHs6QyXfrmvO3K6X+yNENvK+Xp3VfMKH+C56cNJJ1nC9CxvUEuCsR
 lFvbHcMpNs3T7Sit0tNbrIiE4bBSKc7e+VsxTpobZILlqjio9361LLShhtrr4ZtMYgg8bbw==
X-Received: by 2002:a05:6000:2282:b0:439:9124:f2b7 with SMTP id
 ffacd0b85a97d-4399de20546mr22885972f8f.29.1772474115839; 
 Mon, 02 Mar 2026 09:55:15 -0800 (PST)
X-Received: by 2002:a05:6000:2282:b0:439:9124:f2b7 with SMTP id
 ffacd0b85a97d-4399de20546mr22885928f8f.29.1772474115427; 
 Mon, 02 Mar 2026 09:55:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm10686569f8f.25.2026.03.02.09.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:55:15 -0800 (PST)
Message-ID: <981bafba-6041-4b27-a015-d9764950f929@redhat.com>
Date: Mon, 2 Mar 2026 18:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/21/26 11:17 AM, Tao Tang wrote:
> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
> and return CERROR_ILL when stage-1 translation is not implemented,
> matching the architecture requirement (IHI 0070G.b, page 176).
>
> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index fa09099a09a..d4c58c0c724 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1461,6 +1461,15 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>                  break;
>              }
>  
> +            /*
> +             * This command raises CERROR_ILL when stage 1 is not implemented
> +             * according to (IHI 0070G.b) Page 176.
> +             */
> +            if (!STAGE1_SUPPORTED(s)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
>              trace_smmuv3_cmdq_cfgi_cd(sid);
>              smmuv3_flush_config(sdev);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
With the fixed fixes tag,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


