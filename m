Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A7DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticSQ-0004bn-C3; Thu, 13 Feb 2025 11:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ticSL-0004bC-VF
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ticSH-0005CM-4k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739465567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nSIx9szDbtbyAtyq/ZEbhmLgwoEFtUgV+Rg06WFGgQ=;
 b=NOThZJlhNUKx2sGVAOwYR8KOGuh4OFe1U69t2zH+D2nxRkIvobGXWnpwnvsO3yGCPxYYEm
 UTlHViwa8WCQgG+W7NT5KoUQn+XQsB9vF4O9jdXBjQW46jUcMPKdBR/sqLyArokPtEFOxz
 yA8BODmnQUETYgqQcR3bdnJxZwNnqo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-zTlmdHbSOfy90-tyOG-SVQ-1; Thu, 13 Feb 2025 11:52:46 -0500
X-MC-Unique: zTlmdHbSOfy90-tyOG-SVQ-1
X-Mimecast-MFC-AGG-ID: zTlmdHbSOfy90-tyOG-SVQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f27bddeeeso800385f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739465564; x=1740070364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nSIx9szDbtbyAtyq/ZEbhmLgwoEFtUgV+Rg06WFGgQ=;
 b=ORBEkuDmiW5x/cCICLBkQ028AC0y1HiIvejhyL/WY+p9U0NKXpY0B3qE+JE9hgDup0
 tVGvJ1Ox0gq7+m+7UCWrycSM+5RtkSLBiQfx0/QDAiEf8CqOB9pcFl3qFzGRBXEfkohQ
 LycAED+rBNcrk4AKhwCqMuEAKsPRMxWZ0j+fnuD9egC0nLMeYKgXzWNQc9HUBs64Ommm
 BQIKA3HAQsOl+xq5Kv2AD3BhujkYBsZGWuZepyEB4x97z+4/QmbjJLk6nDaIPYVcpESD
 yFtfp9GiMKa/jguKk6cv9km5oCHtW6iVzhsV0OZjiqnqB21Ahoa6AL2cOGaiRAUmBXR3
 1/FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNlNTdFU+m8iFPbt+ZJl17uOOij2ezZQVFA49zjT0pBwv9OJZF7d33D2mkRwSSwBH4JujoBju45FQ3@nongnu.org
X-Gm-Message-State: AOJu0YxvdbjAghmXPveAmDog53A4sigStDGnugRgBvs9WYn0zezQsZ1d
 MGaEp4+FQpKFi5LiRsoBz0xJmMAFOT4F6UcgFGBPszQ86MWQk4NNQK7kGdWCBWwypyWHV7BNYI5
 BmYN4E6HoNlkTod+ZJDFp/bqDqG2ElrdDbxfQ/FQUcRREgpqNYYS8jLtUgid/
X-Gm-Gg: ASbGnct2C5ZrKQCWIogRzNZSRWgnBiys4SIGiRA6Z76JL3ZNW6M+XoIdq2htQRNMFu9
 AkXQ4Al3/N2RchtzZXciz6ym+iFjPZtilntpW26qVcRySpIsyS+MC7quDABbtzgbNFIJn5R42Zy
 RVN4LFoZwpxr9ylU1P/hOMIsOmjcNOCUaxt+efyDvEzIacz6Uidfx4+hWAyWzdDkBDUZE8IU/PP
 V74R99jXuMPguF+b13+InQWr/oKHtsLDEquqKShjXhXjAFXZ9xFytcUG7NTlAlATWIUacQn17Cb
 rUCsfFYVxjmY+LzT9FoURp8+iYMTk64wKgn6UZpDj92BnffkuGws
X-Received: by 2002:a5d:64cf:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-38f244da143mr4712030f8f.9.1739465563708; 
 Thu, 13 Feb 2025 08:52:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE19KG6/E6CMD4a510CdnY+o56NK6yjg5Xuo2YXJw0UoEH+6wCYAlGW1+No1x6ZKg01kkLuVQ==
X-Received: by 2002:a5d:64cf:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-38f244da143mr4711982f8f.9.1739465563242; 
 Thu, 13 Feb 2025 08:52:43 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccef7sm2413675f8f.31.2025.02.13.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:52:42 -0800 (PST)
Date: Thu, 13 Feb 2025 17:52:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
Message-ID: <20250213175241.03bde8c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <3a1f0744-4795-8f07-7258-0922745906ac@loongson.cn>
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <3a1f0744-4795-8f07-7258-0922745906ac@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 13 Feb 2025 17:40:56 +0800
bibo mao <maobibo@loongson.cn> wrote:

> please discard this patch :(
>=20
> libvirt uses static type already on LoongArch platform, there is=20
> compatibility issue. Static type cannot be removed, although I do
> not know the difference between static type and full type.

looking at loongarch-qmp-cmds.c:qmp_query_cpu_model_expansion(),
you do filter reported features by global cpu_model_advertised_features[] l=
ist.
Also cpu 'definition' is mainly governed by its initfn() and
properties mentioned in cpu_model_advertised_features[] are created
only by loongarch_cpu_post_init() , which is part of la464 and max models.
The later call however mutates depending on accelerator, which
sort of contradicts 'static' description and feets more to 'full' category.

What I'd suggest doing is to support both
i.e. do keep 'static' for compat reasons  and run the same code for 'full'

In nutshell drop if(type) check or explicitly allow both types.

>=20
> Regards
> Bibo Mao
>=20
> On 2025/2/13 =E4=B8=8B=E5=8D=885:16, Bibo Mao wrote:
> > With full type for query-cpu-model-expansion qmp command, it shows that
> > it is not supported. For instance,
> >    query-cpu-model-expansion type=3Dfull model=3D{"name":"max"}
> >=20
> > Here is is output,
> >    {"error": {"class": "GenericError", "desc": "The requested expansion=
 type is not supported"}}
> >=20
> > Since full type is not supported and only static type is supported, Here
> > replace static type with full type for command query-cpu-model-expansio=
n.
> >=20
> > And there is result with this patch,
> >    {"return": {"model": {"name": "max", "props": {"lbt": true, "lasx": =
true, "pmu": true, "lsx": true}}}}
> >=20
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >   target/loongarch/loongarch-qmp-cmds.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/l=
oongarch-qmp-cmds.c
> > index 3fde5a5a20..429c6d35fd 100644
> > --- a/target/loongarch/loongarch-qmp-cmds.c
> > +++ b/target/loongarch/loongarch-qmp-cmds.c
> > @@ -56,7 +56,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
> >       const char *name;
> >       int i;
> >  =20
> > -    if (type !=3D CPU_MODEL_EXPANSION_TYPE_STATIC) {


> > +    if (type !=3D CPU_MODEL_EXPANSION_TYPE_FULL) {
> >           error_setg(errp, "The requested expansion type is not support=
ed");
> >           return NULL;
> >       }
> >=20
> > base-commit: de278e54aefed143526174335f8286f7437d20be
> >  =20
>=20
>=20


