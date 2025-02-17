Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBC1C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwk0-0008Ve-KB; Mon, 17 Feb 2025 03:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjwjv-0008U4-VI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:44:33 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjwjq-0004Dt-HI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739781866; x=1771317866;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=M7yQUHU6t4HWidzZtcxLzbRFddm6VNtSozqzjHARHLU=;
 b=YWbfXxhnOu33vSFE4v47OcEIfPHFnI6Xzn4IaA8qXBLZz0lmbCbYOkOz
 MhCNWIA6ePlF0DvvhvWsKx3XHgF6YYt1v74BwsQMfoxRfSudvMxXWrd/q
 oMXpDN3veybLFqF+5FbOMMbeYe6icfbdeZBq4NBAYxg09VAyWql2k1iWF
 738u/Q9a40WOb0oTvv97JGENIX6TETOlQKEVyeWjMQ934iVuQyuJgzJzZ
 G6wrLDGkI8H5Wm9SKWaKB8RJH2MIQce8v4aqFXrTDuWu9ghaBteMR8TYN
 gQEqfLadFdQdyev8we+FLm20GneZ0YEJKSpXV/kVwyo8sOS132QOH58G1 w==;
X-CSE-ConnectionGUID: Qh6dR7laRHWmxWbzXPiBZQ==
X-CSE-MsgGUID: ZSp+GRmeSFmwT3T9Jltwvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44383163"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="44383163"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:44:24 -0800
X-CSE-ConnectionGUID: St4YvA6jTZeaTQHoU+Qvlw==
X-CSE-MsgGUID: yesulfRJTrOeu97AEhBkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="113994555"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 17 Feb 2025 00:44:21 -0800
Date: Mon, 17 Feb 2025 17:03:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 11/17] gdbstub: Try unlinking the unix socket before binding
Message-ID: <Z7L7ewnUi874VizQ@intel.com>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
 <20250210161451.3273284-12-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250210161451.3273284-12-alex.bennee@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Alex and Paolo,

I hit an compiling error with "./configure --enable-rust" at this patch:

[69/124] Compiling Rust source ../rust/qemu-api/tests/tests.rs
FAILED: rust/qemu-api/rust-qemu-api-integration
rustc -C linker=3Dcc -C link-arg=3D-m64 --color=3Dauto -C debug-assertions=
=3Dyes -C overflow-checks=3Dno --crate-type bin -D warnings --edition=3D202=
1 -C opt-level=3D2 -g -D unexpected_cfgs -A unknown_lints -D unsafe_op_in_u=
nsafe_fn --cfg MESON -C default-linker-libraries --crate-name rust_qemu_api=
_integration --emit dep-info=3Drust/qemu-api/rust-qemu-api-integration.d --=
emit link=3Drust/qemu-api/rust-qemu-api-integration --out-dir rust/qemu-api=
/rust-qemu-api-integration.p -C metadata=3D81e2432@@rust-qemu-api-integrati=
on@exe --test --extern qemu_api=3Drust/qemu-api/libqemu_api.rlib --extern q=
emu_api_macros=3Drust/qemu-api-macros/libqemu_api_macros.so -Clink-arg=3D-W=
l,--whole-archive -Clink-arg=3Drust/qemu-api/librust_qemu_api_objs.a -Clink=
-arg=3D-Wl,--no-whole-archive -Clink-arg=3D-Wl,--whole-archive -Clink-arg=
=3Dlibqemuutil.a -Clink-arg=3D-Wl,--no-whole-archive -Clink-arg=3Dsubprojec=
ts/libvhost-user/libvhost-user-glib.a -Clink-arg=3Dsubprojects/libvhost-use=
r/libvhost-user.a -Clink-arg=3D-lnuma -Clink-arg=3D/usr/lib/x86_64-linux-gn=
u/libgio-2.0.so -Clink-arg=3D/usr/lib/x86_64-linux-gnu/libgobject-2.0.so -C=
link-arg=3D/usr/lib/x86_64-linux-gnu/libglib-2.0.so -Clink-arg=3D/usr/lib/x=
86_64-linux-gnu/libgmodule-2.0.so -Clink-arg=3D-pthread -Clink-arg=3D-pthre=
ad -Clink-arg=3D-pthread -Clink-arg=3D-pthread -Lrust/qemu-api -Lrust/qemu-=
api-macros -L. -Lsubprojects/libvhost-user -C 'link-arg=3D-Wl,-rpath,$ORIGI=
N/../qemu-api-macros:/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown=
-linux-gnu/lib' -C link-arg=3D-Wl,-rpath-link,/media/liuzhao/data/qemu-cook=
/build/rust/qemu-api-macros:/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-=
unknown-linux-gnu/lib ../rust/qemu-api/tests/tests.rs
error: linking with `cc` failed: exit status: 1
  |
  =3D note: "cc" "-m64" "/tmp/rustcRWVJWs/symbols.o" "rust/qemu-api/rust-qe=
mu-api-integration.p/rust_qemu_api_integration.rust_qemu_api_integration.e9=
408ebc-cgu.0.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust_qemu_a=
pi_integration.rust_qemu_api_integration.e9408ebc-cgu.1.rcgu.o" "rust/qemu-=
api/rust-qemu-api-integration.p/rust_qemu_api_integration.rust_qemu_api_int=
egration.e9408ebc-cgu.10.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p=
/rust_qemu_api_integration.rust_qemu_api_integration.e9408ebc-cgu.11.rcgu.o=
" "rust/qemu-api/rust-qemu-api-integration.p/rust_qemu_api_integration.rust=
_qemu_api_integration.e9408ebc-cgu.12.rcgu.o" "rust/qemu-api/rust-qemu-api-=
integration.p/rust_qemu_api_integration.rust_qemu_api_integration.e9408ebc-=
cgu.13.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust_qemu_api_int=
egration.rust_qemu_api_integration.e9408ebc-cgu.14.rcgu.o" "rust/qemu-api/r=
ust-qemu-api-integration.p/rust_qemu_api_integration.rust_qemu_api_integrat=
ion.e9408ebc-cgu.2.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust_=
qemu_api_integration.rust_qemu_api_integration.e9408ebc-cgu.3.rcgu.o" "rust=
/qemu-api/rust-qemu-api-integration.p/rust_qemu_api_integration.rust_qemu_a=
pi_integration.e9408ebc-cgu.4.rcgu.o" "rust/qemu-api/rust-qemu-api-integrat=
ion.p/rust_qemu_api_integration.rust_qemu_api_integration.e9408ebc-cgu.5.rc=
gu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust_qemu_api_integration.=
rust_qemu_api_integration.e9408ebc-cgu.6.rcgu.o" "rust/qemu-api/rust-qemu-a=
pi-integration.p/rust_qemu_api_integration.rust_qemu_api_integration.e9408e=
bc-cgu.7.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust_qemu_api_i=
ntegration.rust_qemu_api_integration.e9408ebc-cgu.8.rcgu.o" "rust/qemu-api/=
rust-qemu-api-integration.p/rust_qemu_api_integration.rust_qemu_api_integra=
tion.e9408ebc-cgu.9.rcgu.o" "rust/qemu-api/rust-qemu-api-integration.p/rust=
_qemu_api_integration.29ovwebebub0plh7.rcgu.o" "-Wl,--as-needed" "-L" "rust=
/qemu-api" "-L" "rust/qemu-api-macros" "-L" "." "-L" "subprojects/libvhost-=
user" "-L" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gn=
u/lib/rustlib/x86_64-unknown-linux-gnu/lib" "-Wl,-Bstatic" "/home/liuzhao/.=
rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknow=
n-linux-gnu/lib/libtest-50b9616eedb811b7.rlib" "/home/liuzhao/.rustup/toolc=
hains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/=
lib/libgetopts-754da76e30d40e26.rlib" "/home/liuzhao/.rustup/toolchains/1.6=
3.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libun=
icode_width-abff7c50c58df25c.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0=
-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc=
_std_workspace_std-89f1a8c8e39f4a91.rlib" "/media/liuzhao/data/qemu-cook/bu=
ild/rust/qemu-api/libqemu_api.rlib" "-Wl,--start-group" "/home/liuzhao/.rus=
tup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-l=
inux-gnu/lib/libstd-8f1929c73c3f8167.rlib" "/home/liuzhao/.rustup/toolchain=
s/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/=
libpanic_unwind-e359d865975ccf21.rlib" "/home/liuzhao/.rustup/toolchains/1.=
63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libo=
bject-b886fd10c5a7c7c0.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_6=
4-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libmemchr-9d7c=
322d48daa475.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-=
linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libaddr2line-08ae1606a95=
1cabe.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-g=
nu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libgimli-682a81c4b2133b72.rlib"=
 "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rust=
lib/x86_64-unknown-linux-gnu/lib/librustc_demangle-a73b3512c88de071.rlib" "=
/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustli=
b/x86_64-unknown-linux-gnu/lib/libstd_detect-7b5ec4c918d9f957.rlib" "/home/=
liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_=
64-unknown-linux-gnu/lib/libhashbrown-65c63cf3af0af657.rlib" "/home/liuzhao=
/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unkn=
own-linux-gnu/lib/libminiz_oxide-4a53f0a2785abc6a.rlib" "/home/liuzhao/.rus=
tup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-l=
inux-gnu/lib/libadler-868e2d515c28d027.rlib" "/home/liuzhao/.rustup/toolcha=
ins/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/li=
b/librustc_std_workspace_alloc-394ad2d73aede76a.rlib" "/home/liuzhao/.rustu=
p/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-lin=
ux-gnu/lib/libunwind-19c77e4dc3dcb87e.rlib" "/home/liuzhao/.rustup/toolchai=
ns/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib=
/libcfg_if-fb44a42088c9369a.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-=
x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/liblibc-6=
1a7402e61a5b0e0.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unkno=
wn-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc-63f8356c87a0=
d0e8.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gn=
u/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_std_workspace_core-a506=
e577d917828c.rlib" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-=
linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcore-fc1fb63210fdafad=
=2Erlib" "-Wl,--end-group" "/home/liuzhao/.rustup/toolchains/1.63.0-x86_64-=
unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcompiler_buil=
tins-c21be34a5cae8449.rlib" "-Wl,-Bdynamic" "-lgcc_s" "-lutil" "-lrt" "-lpt=
hread" "-lm" "-ldl" "-lc" "-Wl,--eh-frame-hdr" "-Wl,-znoexecstack" "-L" "/h=
ome/liuzhao/.rustup/toolchains/1.63.0-x86_64-unknown-linux-gnu/lib/rustlib/=
x86_64-unknown-linux-gnu/lib" "-o" "rust/qemu-api/rust-qemu-api-integration=
" "-Wl,--gc-sections" "-pie" "-Wl,-zrelro,-znow" "-Wl,-O1" "-m64" "-Wl,--wh=
ole-archive" "rust/qemu-api/librust_qemu_api_objs.a" "-Wl,--no-whole-archiv=
e" "-Wl,--whole-archive" "libqemuutil.a" "-Wl,--no-whole-archive" "subproje=
cts/libvhost-user/libvhost-user-glib.a" "subprojects/libvhost-user/libvhost=
-user.a" "-lnuma" "/usr/lib/x86_64-linux-gnu/libgio-2.0.so" "/usr/lib/x86_6=
4-linux-gnu/libgobject-2.0.so" "/usr/lib/x86_64-linux-gnu/libglib-2.0.so" "=
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so" "-pthread" "-pthread" "-pthrea=
d" "-pthread" "-Wl,-rpath,$ORIGIN/../qemu-api-macros:/home/liuzhao/.rustup/=
toolchains/1.63.0-x86_64-unknown-linux-gnu/lib" "-Wl,-rpath-link,/media/liu=
zhao/data/qemu-cook/build/rust/qemu-api-macros:/home/liuzhao/.rustup/toolch=
ains/1.63.0-x86_64-unknown-linux-gnu/lib"
  =3D note: /usr/bin/ld: libqemuutil.a.p/stubs_monitor-fd.c.o: in function =
`monitor_get_fd':
          /media/liuzhao/data/qemu-cook/build/../stubs/monitor-fd.c:7: mult=
iple definition of `monitor_get_fd'; libqemuutil.a.p/stubs_monitor-internal=
=2Ec.o:/media/liuzhao/data/qemu-cook/build/../stubs/monitor-internal.c:6: f=
irst defined here
          collect2: error: ld returned 1 exit status


error: aborting due to previous error

---

I tried to analyze the reasons as follows:

* stubs/monitor-fd.c introduces the same monitor_get_fd() stub as the
  stubs/monitor-internal.c did.

* rust-qemu-api-integration used the "link_whole" keyword instead of
  "link_with".=20

Then the two duplicate monitor_get_fd() eventually meet in
rust-qemu-api-integration.

To fix this issue, dropping stubs/monitor-fd.c and only linking
stubs/monitor-internal.c could work! (And I don't think of the reason to
redefine monitor_get_fd() in another file.)

In addition, could we change the "link_whole" to "link_with" when
compile rust-qemu-api-integration?

Thanks,
Zhao


