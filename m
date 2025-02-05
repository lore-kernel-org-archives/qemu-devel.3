Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8149C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbib-0005Ai-0S; Wed, 05 Feb 2025 04:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbiU-0005A6-Kw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbiS-000884-VU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738747743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHa01BNtNcX3iTcO26w0aRNngCZY4JV7FZ6ob4PLOV4=;
 b=arXzTrN4KPWMOgHQeAutdnR0B/QS+dtD1R/GszpGZ5ZN8nECOin5yCeAa3QbgLaXuYjpiG
 zc7kyzyLMGLdkZ1DT4TSAP+1a9BqqoPGEzmvbRVfQejzc18n6fnXTrraq9PxhIyttnL4oi
 diF1EKr3PytpntmIN/SFnD75ANyyrnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-pcs6IkN5NZuN9NGIZ65rrw-1; Wed,
 05 Feb 2025 04:29:01 -0500
X-MC-Unique: pcs6IkN5NZuN9NGIZ65rrw-1
X-Mimecast-MFC-AGG-ID: pcs6IkN5NZuN9NGIZ65rrw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC7B180056F; Wed,  5 Feb 2025 09:29:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BDEB1800360; Wed,  5 Feb 2025 09:28:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C8B021E6A28; Wed, 05 Feb 2025 10:28:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Igor
 Mammedov <imammedo@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Huacai Chen <chenhuacai@kernel.org>,  Rick
 Edgecombe <rick.p.edgecombe@intel.com>,  Francesco Lavra
 <francescolavra.fl@gmail.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 48/52] i386/tdx: Fetch and validate CPUID of TD guest
In-Reply-To: <20250124132048.3229049-49-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Fri, 24 Jan 2025 08:20:44 -0500")
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-49-xiaoyao.li@intel.com>
Date: Wed, 05 Feb 2025 10:28:57 +0100
Message-ID: <87o6zg3fl2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Use KVM_TDX_GET_CPUID to get the CPUIDs that are managed and enfored
> by TDX module for TD guest. Check QEMU's configuration against the
> fetched data.
>
> Print wanring  message when 1. a feature is not supported but requested
> by QEMU or 2. QEMU doesn't want to expose a feature while it is enforced
> enabled.
>
> - If cpu->enforced_cpuid is not set, prints the warning message of both
> 1) and 2) and tweak QEMU's configuration.
>
> - If cpu->enforced_cpuid is set, quit if any case of 1) or 2).
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c     | 33 ++++++++++++++-
>  target/i386/cpu.h     |  7 +++
>  target/i386/kvm/tdx.c | 99 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f1330627adbb..a948fd0bd674 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5482,8 +5482,8 @@ static bool x86_cpu_have_filtered_features(X86CPU *=
cpu)
>      return false;
>  }
>=20=20
> -static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64=
_t mask,
> -                                      const char *verbose_prefix)
> +void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
> +                               const char *verbose_prefix)
>  {
>      CPUX86State *env =3D &cpu->env;
>      FeatureWordInfo *f =3D &feature_word_info[w];
> @@ -5510,6 +5510,35 @@ static void mark_unavailable_features(X86CPU *cpu,=
 FeatureWord w, uint64_t mask,
>      }
>  }
>=20=20
> +void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
> +                             const char *verbose_prefix)
> +{
> +    CPUX86State *env =3D &cpu->env;
> +    FeatureWordInfo *f =3D &feature_word_info[w];
> +    int i;
> +
> +    if (!cpu->force_features) {
> +        env->features[w] |=3D mask;
> +    }
> +
> +    cpu->forced_on_features[w] |=3D mask;
> +
> +    if (!verbose_prefix) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < 64; ++i) {
> +        if ((1ULL << i) & mask) {
> +            g_autofree char *feat_word_str =3D feature_word_description(=
f);

Does not compile for me:

    ../target/i386/cpu.c: In function =E2=80=98mark_forced_on_features=E2=
=80=99:
    ../target/i386/cpu.c:5531:46: error: too few arguments to function =E2=
=80=98feature_word_description=E2=80=99
     5531 |             g_autofree char *feat_word_str =3D feature_word_des=
cription(f);
          |                                              ^~~~~~~~~~~~~~~~~~=
~~~~~~
    ../target/i386/cpu.c:5451:14: note: declared here
     5451 | static char *feature_word_description(FeatureWordInfo *f, uint3=
2_t bit)
          |              ^~~~~~~~~~~~~~~~~~~~~~~~

> +            warn_report("%s: %s%s%s [bit %d]",
> +                        verbose_prefix,
> +                        feat_word_str,
> +                        f->feat_names[i] ? "." : "",
> +                        f->feat_names[i] ? f->feat_names[i] : "", i);
> +        }
> +    }
> +}
> +
>  static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
>                                           const char *name, void *opaque,
>                                           Error **errp)

[...]


