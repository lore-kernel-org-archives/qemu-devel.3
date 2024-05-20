Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0729FC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s936h-0005up-Rt; Mon, 20 May 2024 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s936b-0005uO-Pr
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s936W-0003q3-UF
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716211863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mF42ViA9DX/FcnHEc0NXxAvzMh/D7aDDJG8/LXRooTI=;
 b=d2aSXtvt45RmpYlggQ349OFa5JLoc6pEr1C2B+NbRgcIrdO5QpQIZ5dPhk0bSZlXyE9MWW
 aP61tJ1CpNssCo99Lxm/ox7rQA5ENU6F+ST8DZ6uK0RC3jBY3huKphtvutfeurmQEBDmhd
 viORGlUvkes3ki6Z4b01K8FqeeKQccQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-xfphoqn4PN-hdO7i_LOvYw-1; Mon, 20 May 2024 09:31:02 -0400
X-MC-Unique: xfphoqn4PN-hdO7i_LOvYw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so1147801566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716211861; x=1716816661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mF42ViA9DX/FcnHEc0NXxAvzMh/D7aDDJG8/LXRooTI=;
 b=IykmWUiGWk6OspRuu3Du1ixta+YUCADOWwphHgqtcSw5d4RDnj85gxWztJkhrJxH7n
 A+r+C8joWha3YKDvhTRMPx46BRkUtK1V7s0BzVgjV6IjBj1zYcxcGdAmRjQdxls/RxiA
 WpGKN0xuZiRAJTLkeqCdroIejrXCaceuYM41NrsbiCPKqNC12DUTGCrtdKZVgHU7ywFD
 1uVxBRz3wly/JUQKio9HsQHs6NbntY5SdmIzUTqsZE+n1u707pJu+rWeUEjQ2xSEda2e
 PK5Zk/v8wYhAUrCMbpDDI1kAZKeTmPTU+yyHgg76rsGqRGZEB6nYJroZpXN9/eGv3eeL
 jyHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Q7mdiaNdNSX/+UCVvJ7P7OHUEnw9bcyDKXbryEyWJDJoR0K4LK/0iyyisVlP8ZMf8z1NvwijU+kbEV7Pt3gzL1DdF60=
X-Gm-Message-State: AOJu0YyDHdIiOTSKpEWbKAR8mU15sQQ1RxYwuJjUqmnMh9Qhi6pSxbpd
 7OGjkg5qXxqKmLBhrNIDluh2iDGTnKB3h8xeKEcg2TKia+wO2HOLk8/q8H/wiiXO35Wmc+KPtpl
 epmlpRZ6nmnb5xmozks1p8V4OQU/7T8fJdUkzI6JKoFb+QjwXs+D8
X-Received: by 2002:a17:907:924f:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a5d5a378936mr479323066b.13.1716211861291; 
 Mon, 20 May 2024 06:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnvwXvqXxhJQ/bMfIDRrpZE8D6ncdhPq2L0qZM5Fmfi6Ox0HLK4Xwj+i+Dt6aEXhG2Xpz15Q==
X-Received: by 2002:a17:907:924f:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a5d5a378936mr479319966b.13.1716211860794; 
 Mon, 20 May 2024 06:31:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5ce2982009sm587167666b.90.2024.05.20.06.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 06:31:00 -0700 (PDT)
Message-ID: <b3488980-2136-4620-b875-a11f75373462@redhat.com>
Date: Mon, 20 May 2024 15:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 15/18] hw/arm/smmuv3: Advertise S2FWB
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-16-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-16-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/29/24 05:23, Mostafa Saleh wrote:
> QEMU doesn's support memory attributes, so FWB is NOP, this
> might change in the future if memory attributre would be supported.
if mem attributes get supported
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 88f6473d33..8a11e41144 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
>          /* XNX is a stage-2-specific feature */
>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
> +            /*
> +             * QEMU doesn's support memory attributes, so FWB is NOP, this
> +             * might change in the future if memory attributre would be
if mem attributes get supported
> +             * supported.
> +             */
> +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
spec says:
0b0    Stage 2 control of memory types and attributes is
not supported and the STE.S2FWB bit is RES 0.


Thanks

Eric
> +        }
>      }
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);


