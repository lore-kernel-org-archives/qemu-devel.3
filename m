Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6E1C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYMXd-0002EX-EA; Thu, 16 Jan 2025 04:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYMXS-0002CU-VH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:51:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYMXQ-00053K-92
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737021102;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEeHovypAzxwdby1Lf1QE5hJCpdIZpGUaWbz04FhtfQ=;
 b=Gh0a+B1xVzE2Z/ks0U4uHpX5RYKIa+BeDd61PfiIvnM2g/+rgrGMm92U+OjdmgtId4pxi0
 6MlH6fBJUUlECmAdbYO98AwDrnYTsMMdqqyGptI95nX/ckxJKJesEsXsJcTxgMvKVLXBUu
 E/sF6DeEJrCpw8qSRGfCg9ca3+NH9O8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-6jKakTwkMmWTAoHKpKxGOg-1; Thu,
 16 Jan 2025 04:51:39 -0500
X-MC-Unique: 6jKakTwkMmWTAoHKpKxGOg-1
X-Mimecast-MFC-AGG-ID: 6jKakTwkMmWTAoHKpKxGOg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6A5519560BA; Thu, 16 Jan 2025 09:51:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8782619560BF; Thu, 16 Jan 2025 09:51:20 +0000 (UTC)
Date: Thu, 16 Jan 2025 09:51:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/21] target/i386/cpu: Pass Error** to
 x86_cpu_filter_features()
Message-ID: <Z4jWkf8LxTTMCTkk@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115232247.30364-7-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 16, 2025 at 12:22:32AM +0100, Philippe Mathieu-Daudé wrote:
> Simplify x86_cpu_realizefn() by passing an Error**
> argument to x86_cpu_filter_features().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 42227643126..c48241fb902 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5896,7 +5896,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>      }
>  }
>  
> -static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
> +static bool x86_cpu_filter_features(X86CPU *cpu, Error **errp);
>  
>  /* Build a list with the name of all features on a feature word array */
>  static void x86_cpu_list_feature_names(FeatureWordArray features,
> @@ -6084,7 +6084,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>          error_free(err);
>      }
>  
> -    x86_cpu_filter_features(xc, false);
> +    x86_cpu_filter_features(xc, NULL);
>  
>      x86_cpu_list_feature_names(xc->filtered_features, tail);
>  
> @@ -7650,7 +7650,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>   *
>   * Returns: true if any flag is not supported by the host, false otherwise.
>   */
> -static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> +static bool x86_cpu_filter_features(X86CPU *cpu, Error **errp)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> @@ -7660,7 +7660,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>      uint32_t eax_0, ebx_0, ecx_0, edx_0;
>      uint32_t eax_1, ebx_1, ecx_1, edx_1;
>  
> -    if (verbose) {
> +    if (errp) {
>          prefix = accel_uses_host_cpuid()
>                   ? "host doesn't support requested feature"
>                   : "TCG doesn't support requested feature";
> @@ -7712,15 +7712,13 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>          uint8_t version = ebx_0 & 0xff;
>  
>          if (version < env->avx10_version) {
> -            if (prefix) {
> -                warn_report("%s: avx10.%d. Adjust to avx10.%d",
> -                            prefix, env->avx10_version, version);
> -            }
> +            error_setg(errp, "%s: avx10.%d. Adjust to avx10.%d",
> +                       prefix, env->avx10_version, version);
>              env->avx10_version = version;
>              have_filtered_features = true;

This doesn't look right.  Previously it was correct to carry on and
set  'env->avx10_version = version' or 'have_filtered_features',
because it was upto the caller whether this was an error scenario
or just a warning.

With your change though, we're unambiguously treating this as an
error condition. So we should return from this method immediately
after calling 'error_setg' now.

>          }
>      } else if (env->avx10_version && prefix) {
> -        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> +        error_setg(errp, "%s: avx10.%d.", prefix, env->avx10_version);
>          have_filtered_features = true;

Same here, needs a 'return'

>      }
>  
> @@ -7822,14 +7820,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
> -        if (cpu->enforce_cpuid) {
> -            error_setg(&local_err,
> -                       accel_uses_host_cpuid() ?
> -                       "Host doesn't support requested features" :
> -                       "TCG doesn't support requested features");
> -            goto out;
> -        }
> +    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid ? &local_err : NULL)) {
> +        goto out;
>      }
>  
>      /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
> -- 
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


