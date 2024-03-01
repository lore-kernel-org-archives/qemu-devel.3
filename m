Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7020EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg50f-0003It-CY; Fri, 01 Mar 2024 10:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rg50c-0003If-0Q
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:41:14 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rg50Z-0004Cu-TW
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709307672; x=1740843672;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UCgBJnXG/UO0SnvFRzOsMeOMKa+CebSwf5Cpb4EnGYc=;
 b=a3lrihgG3KHpmprjALkaRlSB31JIlljwFU5H3f/EIJS4eN9k1nVSQEf2
 1FNUh8ter5TVXdr6Mg7rqZtX5Zyrc3EVze7ZFgN8turTdI8qYPbzoT9zU
 /fCJN81lJjRVtSEJbYeIcQFgG3zNrZ7FajwqZe5ufnviu9+W2q+aWRlUB
 JJEHehQbIyUdhFrttd2Xc5z0EOIVCBMqEAXLkNwu30GZt2hr9SSCIRDHF
 IAUpZvsRPZ5xJ1MCVkiBpULzG7WiQKQGGFDq+QtkWAQmsjiRhbD12e6dO
 GfiQMMb8t9yN4dTW31vpAV8yV5qcyW4KPSPrLvhR8bZLRFY/0E1VHmPMP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3705949"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3705949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 07:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8657143"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 01 Mar 2024 07:41:08 -0800
Date: Fri, 1 Mar 2024 23:54:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
Message-ID: <ZeH6S02g5n/2TzaN@intel.com>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
 <ZeGBl5eJoJ0PLrW3@intel.com> <87msri5k1b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msri5k1b.fsf@draig.linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 10:22:08AM +0000, Alex Benn¨¦e wrote:
> Date: Fri, 01 Mar 2024 10:22:08 +0000
> From: Alex Benn¨¦e <alex.bennee@linaro.org>
> Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
>  changes
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi Alex,
> >
> > I hit the following warnings (with "./configure --enable-werror"):
> >
> > /qemu/contrib/plugins/execlog.c: In function ¡®registers_init¡¯:
> > /qemu/contrib/plugins/execlog.c:330:17: warning: ¡®g_pattern_match_string¡¯ is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
> >   330 |                 if (g_pattern_match_string(pat, rd->name) ||
> >       |                 ^~
> > In file included from /usr/include/glib-2.0/glib.h:65,
> >                  from /qemu/contrib/plugins/execlog.c:9:
> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >       |               ^~~~~~~~~~~~~~~~~~~~~~
> > /qemu/contrib/plugins/execlog.c:331:21: warning: ¡®g_pattern_match_string¡¯ is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
> >   331 |                     g_pattern_match_string(pat, rd_lower)) {
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~
> > In file included from /usr/include/glib-2.0/glib.h:65,
> >                  from /qemu/contrib/plugins/execlog.c:9:
> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >       |               ^~~~~~~~~~~~~~~~~~~~~~
> > /qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 of ¡®g_ptr_array_add¡¯ discards ¡®const¡¯ qualifier from pointer target type [-Wdiscarded-qualifiers]
> >   339 |                             g_ptr_array_add(all_reg_names,
> > reg->name);
> 
> Hmm I missed that. Not sure what the neatest solution is in this case -
> g_ptr_array_new() doesn't have a destroy func so we shouldn't ever
> attempt to free it. We can manually re-add the const qualifier at the
> other end for completeness and I guess comment and cast?

I find other palces use 2 ways:
  * Use g_strdup() to create a copy (e.g., net/net.c,
    add_nic_model_help()). But I'm not sure if this is OK since you said
    we shouldn't attempt to free it. May I ask if the free issue you
    mentioned will affect the use of g_strdup() here?
  * Another way is the forced conversion to gpointer (also e.g., in
    net/net.c, qemu_get_nic_models()).

Which way do you like? ;-)

> 
> 
> >       |                                                            ~~~^~~~~~
> > In file included from /usr/include/glib-2.0/glib.h:31,
> >                  from /qemu/contrib/plugins/execlog.c:9:
> > /usr/include/glib-2.0/glib/garray.h:192:62: note: expected ¡®gpointer¡¯ {aka ¡®void *¡¯} but argument is of type ¡®const char *¡¯
> >   192 |                                            gpointer          data);
> >       |                                            ~~~~~~~~~~~~~~~~~~^~~~
> >
> > In addition, I checked my glic version:
> >
> > $ldd --version
> > ldd (Ubuntu GLIBC 2.35-0ubuntu3.5) 2.35
> >
> > I think it's v2.35. Are these three warning reports valid?
> 
> It's the glib (not glibc) version that matters here.
> g_pattern_match_string was deprecated in 2.70 when the suggested
> alternative was added. However our baseline for glib is still:
> 
>   # When bumping glib minimum version, please check also whether to increase
>   # the _WIN32_WINNT setting in osdep.h according to the value from glib
>   glib_req_ver = '>=2.56.0'
>   glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
>                       method: 'pkg-config')
> 
> The usual solution for this is to throw in a compat wrapper in
> glib-compat.h:
> 
> --8<---------------cut here---------------start------------->8---
> modified   include/glib-compat.h
> @@ -105,6 +105,24 @@ static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
>  }
>  #define g_memdup2(m, s) g_memdup2_qemu(m, s)
>  
> +/*
> + * g_pattern_match_string has been deprecated in Glib since 2.70 and
> + * will complain about it if you try to use it. Fortunately the
> + * signature of both functions is the same making it easy to work
> + * around.
> + */
> +static inline
> +gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
> +                                          const gchar *string)
> +{
> +#if GLIB_CHECK_VERSION(2, 70, 0)
> +    return g_pattern_spec_match_string(pspec, string);
> +#else
> +    return g_pattern_match_string(pspec, string);
> +#endif
> +};
> +#define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu(p, s)
> +
>  #if defined(G_OS_UNIX)
>  /*
>   * Note: The fallback implementation is not MT-safe, and it returns a copy of
> modified   contrib/plugins/execlog.c
> @@ -334,8 +334,8 @@ static void registers_init(int vcpu_index)
>              for (int p = 0; p < rmatches->len; p++) {
>                  g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
>                  g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
> -                if (g_pattern_match_string(pat, rd->name) ||
> -                    g_pattern_match_string(pat, rd_lower)) {
> +                if (g_pattern_spec_match_string(pat, rd->name) ||
> +                    g_pattern_spec_match_string(pat, rd_lower)) {
>                      Register *reg = init_vcpu_register(vcpu_index, rd);
>                      g_ptr_array_add(registers, reg);
> --8<---------------cut here---------------end--------------->8---
> 
> but I hesitated to add it for this case as plugins shouldn't assume they
> have access to QEMU's internals. Maybe the glib-compat.h header could be
> treated as a special case.

Thanks! This works on my side!

I support to fix the compatibility as the above, after all it's always
confusing when we allow users to use newer glib and see warnings at
compile time!

> >
> > I also noticed in target/arm/helper.c, there's another
> > g_pattern_match_string() but I haven't met the warning.
> 
> Hmm that's weird. I suspect glib suppresses the warnings with:
> 
>   /* Ask for warnings for anything that was marked deprecated in
>    * the defined version, or before. It is a candidate for rewrite.
>    */
>   #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56
>

I'm not too familiar with the QEMU build framework, but based on this, a
natural question is, can this rule be applied to plugins code as well?
If so, this would also avoid warning.

Thanks,
Zhao


