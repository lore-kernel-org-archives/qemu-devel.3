Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D71C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 06:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgJBM-0000NE-Ls; Sat, 02 Mar 2024 01:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rgJBK-0000Ms-Vl
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 01:49:15 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rgJBH-0005MK-RK
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 01:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709362152; x=1740898152;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cgvwG16dFrdi58ovdmFbQCI8PafDV6LOzqp/GFGwnK4=;
 b=LlyeWln/bSI9VQJDCw/HPRfP3RawqtGcZjBvlFYfsO7d76BdrsQKTB+D
 03cjhUnu7QtDY1UW/bnY6ThWbChAH3FgHRhrXUVDY+LoGUdR0FfvhuU0P
 CsEl4UB1PQYhxdl3MIRh77YV0t+flUXr1sedXW9kW8AVr7PO1lobk7cxk
 akXs9fnX+pxA5cQNqjJYZSNcGoXcGMGbBTw0b0qwYyxSIZzR3deItLMGD
 XTGQ6YT9nPOIzMpJewQ19bin/4AQpK8X60tNtgqja3YELWxv6Ouy7KFUK
 VlSp3+yRIC+gk8DW6cEsFvy1ZZklGSIsCxCcviz+fxDzGEX5/UaOsKvJ2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15321671"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; d="scan'208";a="15321671"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 22:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8480121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 22:49:06 -0800
Date: Sat, 2 Mar 2024 15:02:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
Message-ID: <ZeLPGcCkPfj+ULZJ@intel.com>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
 <ZeGBl5eJoJ0PLrW3@intel.com> <87msri5k1b.fsf@draig.linaro.org>
 <ZeH6S02g5n/2TzaN@intel.com> <87zfvh52ys.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87zfvh52ys.fsf@draig.linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 01, 2024 at 04:30:51PM +0000, Alex Benn=A8=A6e wrote:
> Date: Fri, 01 Mar 2024 16:30:51 +0000
> From: Alex Benn=A8=A6e <alex.bennee@linaro.org>
> Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track regist=
er
>  changes
>=20
> Zhao Liu <zhao1.liu@intel.com> writes:
>=20
> > On Fri, Mar 01, 2024 at 10:22:08AM +0000, Alex Benn=A8=A6e wrote:
> >> Date: Fri, 01 Mar 2024 10:22:08 +0000
> >> From: Alex Benn=A8=A6e <alex.bennee@linaro.org>
> >> Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track reg=
ister
> >>  changes
> >>=20
> >> Zhao Liu <zhao1.liu@intel.com> writes:
> >>=20
> >> > Hi Alex,
> >> >
> >> > I hit the following warnings (with "./configure --enable-werror"):
> >> >
> >> > /qemu/contrib/plugins/execlog.c: In function =A1=AEregisters_init=A1=
=AF:
> >> > /qemu/contrib/plugins/execlog.c:330:17: warning: =A1=AEg_pattern_mat=
ch_string=A1=AF is deprecated: Use 'g_pattern_spec_match_string' instead [-=
Wdeprecated-declarations]
> >> >   330 |                 if (g_pattern_match_string(pat, rd->name) ||
> >> >       |                 ^~
> >> > In file included from /usr/include/glib-2.0/glib.h:65,
> >> >                  from /qemu/contrib/plugins/execlog.c:9:
> >> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
> >> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >> >       |               ^~~~~~~~~~~~~~~~~~~~~~
> >> > /qemu/contrib/plugins/execlog.c:331:21: warning: =A1=AEg_pattern_mat=
ch_string=A1=AF is deprecated: Use 'g_pattern_spec_match_string' instead [-=
Wdeprecated-declarations]
> >> >   331 |                     g_pattern_match_string(pat, rd_lower)) {
> >> >       |                     ^~~~~~~~~~~~~~~~~~~~~~
> >> > In file included from /usr/include/glib-2.0/glib.h:65,
> >> >                  from /qemu/contrib/plugins/execlog.c:9:
> >> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
> >> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >> >       |               ^~~~~~~~~~~~~~~~~~~~~~
> >> > /qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 =
of =A1=AEg_ptr_array_add=A1=AF discards =A1=AEconst=A1=AF qualifier from po=
inter target type [-Wdiscarded-qualifiers]
> >> >   339 |                             g_ptr_array_add(all_reg_names,
> >> > reg->name);
> >>=20
> >> Hmm I missed that. Not sure what the neatest solution is in this case -
> >> g_ptr_array_new() doesn't have a destroy func so we shouldn't ever
> >> attempt to free it. We can manually re-add the const qualifier at the
> >> other end for completeness and I guess comment and cast?
> >
> > I find other palces use 2 ways:
> >   * Use g_strdup() to create a copy (e.g., net/net.c,
> >     add_nic_model_help()). But I'm not sure if this is OK since you said
> >     we shouldn't attempt to free it. May I ask if the free issue you
> >     mentioned will affect the use of g_strdup() here?
>=20
> If we g_strdup we have to remember to free later and ensure the
> g_ptr_array has a free func.

Got it. Thanks!
=20
> >   * Another way is the forced conversion to gpointer (also e.g., in
> >     net/net.c, qemu_get_nic_models()).
>=20
> I think this is ok, but with a comment on all_reg_names just to remind
> any potential users that the strings are const and allocated by QEMU so
> are not to be modified or freed.
>=20

Yes, this makes sense.

> > Which way do you like? ;-)
> >
> <snip>
> >>=20
> >> but I hesitated to add it for this case as plugins shouldn't assume th=
ey
> >> have access to QEMU's internals. Maybe the glib-compat.h header could =
be
> >> treated as a special case.
> >
> > Thanks! This works on my side!
> >
> > I support to fix the compatibility as the above, after all it's always
> > confusing when we allow users to use newer glib and see warnings at
> > compile time!
> >
> >> >
> >> > I also noticed in target/arm/helper.c, there's another
> >> > g_pattern_match_string() but I haven't met the warning.
> >>=20
> >> Hmm that's weird. I suspect glib suppresses the warnings with:
> >>=20
> >>   /* Ask for warnings for anything that was marked deprecated in
> >>    * the defined version, or before. It is a candidate for rewrite.
> >>    */
> >>   #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56
> >>
> >
> > I'm not too familiar with the QEMU build framework, but based on this, a
> > natural question is, can this rule be applied to plugins code as well?
> > If so, this would also avoid warning.
>=20
> I think the simplest solution would be to add:
>=20
>   #include "glib-compat.h"
>=20
> into qemu-plugin.h so plugins have the same deprecation rules as the
> QEMU they come from. I checked with Michael on IRC and Debian currently
> doesn't package any header files but if anyone starts shipping a qemu-dev
> package we'll need to make sure we include glib-compat.h in the same
> directory and qemu-plugin.h.

I teseted this way, and met these error and warnings:

$ make -j16
changing dir to build for make ""...
make[1]: Entering directory '/qemu/build'
In file included from /qemu/contrib/plugins/execlog.c:16:
/qemu/contrib/plugins/../../include/qemu/qemu-plugin.h:19:10: fatal error: =
glib-compat.h: No such file or directory
   19 | #include "glib-compat.h"
      |          ^~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:49: execlog.o] Error 1
make[1]: *** [Makefile:182: contrib/plugins/all] Error 2
make[1]: *** Waiting for unfinished jobs....
[1/2014] Compiling C object tests/plugin/libempty.so.p/empty.c.o
FAILED: tests/plugin/libempty.so.p/empty.c.o
cc -m64 -mcx16 -Itests/plugin/libempty.so.p -Itests/plugin -I../tests/plugi=
n -I../include/qemu -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/gli=
b-2.0/include -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=
=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpa=
nsion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimpl=
icit-fallthrough=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-proto=
types -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wred=
undant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wv=
la -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative=
-value -isystem /qemu/linux-headers -isystem linux-headers -iquote . -iquot=
e /qemu -iquote /qemu/include -iquote /qemu/host/include/x86_64 -iquote /qe=
mu/host/include/generic -iquote /qemu/tcg/i386 -pthread -D_GNU_SOURCE -D_FI=
LE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -f=
wrapv -fzero-call-used-regs=3Dused-gpr -fPIC -MD -MQ tests/plugin/libempty.=
so.p/empty.c.o -MF tests/plugin/libempty.so.p/empty.c.o.d -o tests/plugin/l=
ibempty.so.p/empty.c.o -c ../tests/plugin/empty.c
In file included from ../include/qemu/qemu-plugin.h:19,
                 from ../tests/plugin/empty.c:14:
/qemu/include/glib-compat.h:22: error: "GLIB_VERSION_MIN_REQUIRED" redefine=
d [-Werror]
   22 | #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56
      |
In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from ../include/qemu/qemu-plugin.h:14,
                 from ../tests/plugin/empty.c:14:
/usr/include/glib-2.0/glib/gversionmacros.h:335: note: this is the location=
 of the previous definition
  335 | # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
      |
In file included from ../include/qemu/qemu-plugin.h:19,
                 from ../tests/plugin/empty.c:14:
/qemu/include/glib-compat.h:27: error: "GLIB_VERSION_MAX_ALLOWED" redefined=
 [-Werror]
   27 | #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_56
      |
In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from ../include/qemu/qemu-plugin.h:14,
                 from ../tests/plugin/empty.c:14:
/usr/include/glib-2.0/glib/gversionmacros.h:364: note: this is the location=
 of the previous definition
  364 | # define GLIB_VERSION_MAX_ALLOWED      (GLIB_VERSION_CUR_STABLE)
      |
cc1: all warnings being treated as errors


For redefination warings, I think it's because qemu-plugin.h has
included <glib.h>...so it seems this way is still not clean.

As a comparison, it may be that we also have to go with
g_pattern_spec_match_string_qemu(), which also avoids the potential
problems you mentioned with the possible qemu-dev package.

Will you send the cleanups for those warnings? If you're pressed for
time, I'd be happy to help you send them. ;-)

Thanks,
Zhao


