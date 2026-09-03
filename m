Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D4C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AWp-0001ki-JL; Thu, 03 Sep 2026 12:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2AWm-0001kL-SH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:43:04 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2AWk-0003lM-7e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:43:04 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso436066b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453780; cv=none;
 d=google.com; s=arc-20260327;
 b=KgJlqfQLEZHMX9BnnzZ62BQPBcQ1ccB7NAeNAyCd57bshSHtsEcjXgeJYcYqAMx7qp
 RAJMEd18zUE7oM97KOBGdYgwpfmYJf9cVjPc6n+D/9uzWVEmysjRUeoGWCyqG9LX4l1p
 CmwTryS869y5skq9LZvLtxz6Y+f4Npl99PmeGCvdAf+OXlVYBo21bUlKc/okpoeCxGih
 yxzf/OKTOqlP06+EBgalxjvtYcGt6ted9Y8B3t8JoVc4yy1CDhfsfYWXodYY/mOH51Pk
 GUQJQDzbySW8MgqniGgQI0HM8eFMEliVgrZ1Nzej6rFW0xotUs4sxplzFACbhL3Ri6Ts
 lI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zpc7+YAH2nunU5y/qB3Ny39IDpuCdtFC/oXisLzOa+U=;
 fh=YhbaMNOOLXcMFgCL8mnMv4gkWhkWH8FvjwKb3hfqucI=;
 b=HNE4s7A91+/0eJwpxZaRTwpyUYyP71kV0Ictd3CA9zate5Bz1UaaOfz3sEvmm+ZBMs
 MvYY/FBCIy/21fmifdXRBrjswa2ZPbR7pnRIpzEIMPX4xHtAW46fYi7fXHQxojWYHC0m
 CtPFczzKiV3Rfx731N6wvploVrl/jC5i8ftbMjjAm4ZxaDO5/21xERqnleIrMvIxxbgw
 yrtTvxlefGQJREUvLJKiOWWoy9YrW0GAos8iyzHlElN4a+Tavytc7eJ1wCvxH0JK2/JA
 tI6xWyNWiHGYDfcHtaAItowFWW5WHT4cv1JIJsSYBRUkqvqtaN1CJ54kU6XuvqgT9B1d
 0Unw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788453780; x=1789058580; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zpc7+YAH2nunU5y/qB3Ny39IDpuCdtFC/oXisLzOa+U=;
 b=TzTVNza5kD8CdYd7cOyfgPjc/HIs6XI1wg6/DFnKXQT4+pZtiUmMEHWevQIUgEfUwV
 I0fJCvzdrSs5SJvtwFbzz+fURjiu5UEMrB9eEauc0mlERb8kLEELb1gthsq2NAgtYguH
 tRQ1zDDh+BIUoOpUb6zV1AYLxuBF9MeWuLiIbyUp0vW6tNyYtaYFab7FqoUe4nNKrxdD
 hzVwgkNu0yOmN2uZh4LbN4VzS5+fBHfuz65tP5hV09+HVsfL8c+AhTcrzoRyPQQdNHw2
 G473fVtZWA8Ro55iG6l8v65/uRdyedqB+XIDgO0DbTUVz3Rkck5VcNITLpdRBWdFnElE
 UdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453780; x=1789058580;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zpc7+YAH2nunU5y/qB3Ny39IDpuCdtFC/oXisLzOa+U=;
 b=a9zGPxE4rWQtkkhjfRqcNVo7mWqdo/yKA1cffXolX0PCfP5gxawAsd4BFpFXeDMexx
 5EkhSglHK9hCeaadqmIUP2wGFog090j5iEOkvPLeVOMaCR4AIklaF07RISrke3f7OVSj
 ulfuUPlrnoaiFbjChk0R2pzKOhQ2TAiu39uIJJAGxI/bBWP1TNkOky8a2L0dtYFy8iLs
 UAByqgiwe4xgt5RwvJNT5U7BUwqYRPJKOTs6VtMtjFVhlhpC2+rsBzTufmpV2OShwOmI
 lbJor+1ZWSlUH9HTPJ7K/elBLBB3MonhCz8t8G2TigC89ZaA8U++U7SkS3jCE5A2aUo6
 xYkw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMWYOrSqSaPWIga/zq4z5SWQcYagpt5CmOia6s5lpYJISLCQOXCFa4eCWmxAv3hyMKOEVeZt4w9nga@nongnu.org
X-Gm-Message-State: AFuF++nVJclcIgtRyLAu2mXcyJZgU81ghrb8UBRU8R53mUotHRITsLkG
 2wZ6ZkHLzMCXK+HQPP+OHDW/p4k+aUEHpKupIj4OTSXS/R7t7AN7EQhjrKWnLWq7+puCUie/w/T
 pMrHFQEDlKQ3NgpnXxV7jYAanm30VZR6/uGhRovQ=
X-Gm-Gg: AYBFou0gk31Wk8ihKdHnFR5znEY/S1WWFDCCrvzmry9+jFBHTaettYU+ZWT/UEoae6w
 KNAPPSELUomKNpAMVpT99qag7veXJYqX503hKUo/kverxjdftjqAujZYD6ljmSP4MJtv4jNKtca
 3x5S9DZXld94kJGcp1SKyPUTKtEKqVAhuDVRuLFzYDGcSOtMxoPF24ipIY7//ucjqQLjHSWB/F9
 e3OGXPOOn0dyOz++n0dPCu5Oe8ahbL9oONc7DOOY94mxn5Uv3kNE23f50UxDupysqPe3MVA8scN
 Rh1kk1WmGilQaF3WAdrAHIREiLBKDRIqmZJLopoXaKxQzQjedi3FmucG
X-Received: by 2002:a17:907:d28:b0:c25:9b8:30d6 with SMTP id
 a640c23a62f3a-c25d548f3a5mr958605166b.12.1788453779957; Thu, 03 Sep 2026
 09:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
 <CAE2XoE_zkdFEFLp_eaKbX0ftROPJXxGQvv81z6CQrdjx2k5Y8g@mail.gmail.com>
 <44d0f561-e713-420a-a648-c7199b20425a@oss.qualcomm.com>
In-Reply-To: <44d0f561-e713-420a-a648-c7199b20425a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2026 00:42:46 +0800
X-Gm-Features: AcwNN1UxBl0Rm1N4N19qcY6Da97PpVFnJsmpuRt9djtzh9njhcvGYGPsAHKw85c
Message-ID: <CAE2XoE866Oi_LKi=U10HdOB4TZwgni7R28foJsv203KavhdRtQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] target-info: remove machine_typename
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000406c04065a96d866"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000406c04065a96d866
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 12:28=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/3/2026 3:33 AM, Yonggang Luo wrote:
> >
> >
> >>
> >> > Pierrick Bouvier (14):
> >> >    qom/object: add is_available callback to TypeInfo
> >>
> >
> > Patches for is_available callback to TypeInfo, it's can be merged latte=
r
> >
>
> It's needed because files in patch 2 already depend on existing
> filtering mechanism to distinguish between arm and aarch64.
> We found other places where such filter could be used to specify target
> related types within a single C file, thus allowing to remove #ifdef
> TARGET_X easily.
>
> > The reason is for the following command to execute:
> >
> > we need add target_info_select and pass TargetInfo to is_available
> >
> > - Move target_info() into qom/object.c. Default to SYS_EMU_TARGET_NONE
> >   until a real target is selected.
> > - Add target_info_select(); it may be called only once with a non-NULL
> >   TargetInfo that is not SYS_EMU_TARGET_NONE.
> > - Invoke TypeInfo.is_available after select, passing target_info().
> > - Change target_* helpers to take const TargetInfo *.
>
> We can wait to have a need for this. As long as there is no
> heterogeneous support, it's safe to assume there is a single target
> active globally.


Because we would have more and more usage of target_* , that's why I would
suggest merge it as early as possible. I means directly usage of these
functions.
Not use is_avaible, for example:

--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -420,7 +420,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
     }

     for (i =3D 0; i < sc->num_cpus; i++) {
-        if (qtest_enabled() && !target_aarch64()) {
+        if (qtest_enabled() && !target_aarch64(target_info())) {
             /*
              * Introspection qtest just want to create this object
              * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
@@ -703,7 +703,7 @@ static void aspeed_soc_ast2700_realize(DeviceState
*dev, Error **errp)
     qemu_irq irq;
     int uart;

-    if (qtest_enabled() && !target_aarch64()) {
+    if (qtest_enabled() && !target_aarch64(target_info())) {
         g_assert_not_reached();
     }

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11f..dbdf55dfea9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4132,7 +4132,7 @@ static GPtrArray *virt_get_valid_cpu_types(const
MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v8")));
     }
-    if (tcg_enabled() && target_aarch64()) {
+    if (tcg_enabled() && target_aarch64(target_info())) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
@@ -4144,7 +4144,7 @@ static GPtrArray *virt_get_valid_cpu_types(const
MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max-v9")));
     }
-    if (target_aarch64()) {
+    if (target_aarch64(target_info())) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
         if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 88d01960a01..2a924cab4f7 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -97,7 +97,7 @@ static char *build_eif(const char *kernel_data, gsize
kernel_size,
     hdr =3D (EifHeader) {
         .magic =3D EIF_MAGIC,
         .version =3D cpu_to_be16(4),
-        .flags =3D cpu_to_be16(target_aarch64() ? EIF_HDR_ARCH_ARM64 : 0),
+        .flags =3D cpu_to_be16(target_aarch64(target_info()) ?
EIF_HDR_ARCH_ARM64 : 0),
     };

     g_byte_array_append(buf, (const uint8_t *)&hdr, sizeof(hdr));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c15f2b9f084..26003f2b4df 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2888,7 +2888,7 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
     ObjectClass *oc =3D OBJECT_CLASS(dc);

     /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
+    if (target_s390x(target_info())) {
         object_class_property_add_str(oc, "loadparm",
                                       pci_qdev_property_get_loadparm,
                                       pci_qdev_property_set_loadparm);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a42f7d8e77d..31170e87a33 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3190,7 +3190,7 @@ static void scsi_property_add_specifics(DeviceClass
*dc)
     ObjectClass *oc =3D OBJECT_CLASS(dc);

     /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
+    if (target_s390x(target_info())) {
         object_class_property_add_str(oc, "loadparm",
                                       scsi_property_get_loadparm,
                                       scsi_property_set_loadparm);
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index a06cbf3c646..3d747b470cc 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -54,7 +54,7 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
      * See commit d329f5032e17 ("vfio: Move the saving of the config space
to
      * the right place in VFIO migration").
      */
-    return target_base_arm();
+    return target_base_arm(target_info());
 }

 /* type safety */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2881cec72d9..3383af64859 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2631,7 +2631,7 @@ static int vhost_user_backend_init(struct vhost_dev
*dev, void *opaque,
                 return -EINVAL;
             }

-            const uint64_t vhost_user_max_ram_slots =3D target_base_ppc() =
?
+            const uint64_t vhost_user_max_ram_slots =3D
target_base_ppc(target_info()) ?
                 SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
             u->user->memory_slots =3D MIN(ram_slots,
vhost_user_max_ram_slots);
         }
diff --git a/include/qemu/target-info-impl.h
b/include/qemu/target-info-impl.h
index cf42aabbc8b..61404baa4b5 100644
--- a/include/qemu/target-info-impl.h


any way, we can wait the following pull to be merged first

[PULL 00/51] Misc HW/accel patches for 2026-09-03
https://patchew.org/QEMU/20260903103936.62355-1-philmd@oss.qualcomm.com/


and a better way to deal with it would be appreciated.

I also have patches for riscv needs this.



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000406c04065a96d866
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br>On Fri, Sep 4, 2=
026 at 12:28=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bou=
vier@oss.qualcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com<=
/a>&gt; wrote:<br>&gt;<br>&gt; On 9/3/2026 3:33 AM, Yonggang Luo wrote:<br>=
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; &gt; Pierrick Bouv=
ier (14):<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0qom/object: add is_available c=
allback to TypeInfo<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&gt; &gt; Patches for =
is_available callback to TypeInfo, it&#39;s can be merged latter<br>&gt; &g=
t;<br>&gt;<br>&gt; It&#39;s needed because files in patch 2 already depend =
on existing<br>&gt; filtering mechanism to distinguish between arm and aarc=
h64.<br>&gt; We found other places where such filter could be used to speci=
fy target<br>&gt; related types within a single C file, thus allowing to re=
move #ifdef<br>&gt; TARGET_X easily.<br>&gt;<br>&gt; &gt; The reason is for=
 the following command to execute:<br>&gt; &gt;<br>&gt; &gt; we need add ta=
rget_info_select and pass TargetInfo to is_available<br>&gt; &gt;<br>&gt; &=
gt; - Move target_info() into qom/object.c. Default to SYS_EMU_TARGET_NONE<=
br>&gt; &gt; =C2=A0 until a real target is selected.<br>&gt; &gt; - Add tar=
get_info_select(); it may be called only once with a non-NULL<br>&gt; &gt; =
=C2=A0 TargetInfo that is not SYS_EMU_TARGET_NONE.<br>&gt; &gt; - Invoke Ty=
peInfo.is_available after select, passing target_info().<br>&gt; &gt; - Cha=
nge target_* helpers to take const TargetInfo *.<br>&gt;<br>&gt; We can wai=
t to have a need for this. As long as there is no<br>&gt; heterogeneous sup=
port, it&#39;s safe to assume there is a single target<br>&gt; active globa=
lly.<br><br><br>Because we would have more and more usage of target_* , tha=
t&#39;s why I would suggest merge it as early as possible. I means directly=
 usage of these functions.<br>Not use is_avaible, for example:<br><br>--- a=
/hw/arm/aspeed_ast27x0.c<br>+++ b/hw/arm/aspeed_ast27x0.c<br>@@ -420,7 +420=
,7 @@ static void aspeed_soc_ast2700_init(Object *obj)<br>=C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; sc-&gt;num_cpus;=
 i++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qtest_enabled() &amp;&amp; !tar=
get_aarch64()) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qtest_enabled() &amp;&=
amp; !target_aarch64(target_info())) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * I=
ntrospection qtest just want to create this object<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * without realizing it. ARM_CPU_TYPE_NAME(&quot=
;cortex-a35&quot;)<br>@@ -703,7 +703,7 @@ static void aspeed_soc_ast2700_re=
alize(DeviceState *dev, Error **errp)<br>=C2=A0 =C2=A0 =C2=A0qemu_irq irq;<=
br>=C2=A0 =C2=A0 =C2=A0int uart;<br>=C2=A0<br>- =C2=A0 =C2=A0if (qtest_enab=
led() &amp;&amp; !target_aarch64()) {<br>+ =C2=A0 =C2=A0if (qtest_enabled()=
 &amp;&amp; !target_aarch64(target_info())) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_assert_not_reached();<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>dif=
f --git a/hw/arm/virt.c b/hw/arm/virt.c<br>index 0871a35e11f..dbdf55dfea9 1=
00644<br>--- a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -4132,7 +4132,7 @=
@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_N=
AME(&quot;cortex-a15&quot;)));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_a=
rray_add(vct, g_strdup(ARM_CPU_TYPE_NAME(&quot;max-v8&quot;)));<br>=C2=A0 =
=C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0if (tcg_enabled() &amp;&amp; target_aarch6=
4()) {<br>+ =C2=A0 =C2=A0if (tcg_enabled() &amp;&amp; target_aarch64(target=
_info())) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_add(vct, g_str=
dup(ARM_CPU_TYPE_NAME(&quot;cortex-a35&quot;)));<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME(&quot;cortex-a=
55&quot;)));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_add(vct, g_st=
rdup(ARM_CPU_TYPE_NAME(&quot;cortex-a72&quot;)));<br>@@ -4144,7 +4144,7 @@ =
static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_N=
AME(&quot;neoverse-n2&quot;)));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_=
array_add(vct, g_strdup(ARM_CPU_TYPE_NAME(&quot;max-v9&quot;)));<br>=C2=A0 =
=C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0if (target_aarch64()) {<br>+ =C2=A0 =C2=A0=
if (target_aarch64(target_info())) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g=
_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME(&quot;cortex-a53&quot;)));<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ptr_array_add(vct, g_strdup(ARM_CPU_T=
YPE_NAME(&quot;cortex-a57&quot;)));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (kvm_enabled() || hvf_enabled() || whpx_enabled()) {<br>diff --git a/hw/ni=
tro/machine.c b/hw/nitro/machine.c<br>index 88d01960a01..2a924cab4f7 100644=
<br>--- a/hw/nitro/machine.c<br>+++ b/hw/nitro/machine.c<br>@@ -97,7 +97,7 =
@@ static char *build_eif(const char *kernel_data, gsize kernel_size,<br>=
=C2=A0 =C2=A0 =C2=A0hdr =3D (EifHeader) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.magic =3D EIF_MAGIC,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.version =
=3D cpu_to_be16(4),<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D cpu_to_be16(=
target_aarch64() ? EIF_HDR_ARCH_ARM64 : 0),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags =3D cpu_to_be16(target_aarch64(target_info()) ? EIF_HDR_ARCH_ARM6=
4 : 0),<br>=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0g_byte_a=
rray_append(buf, (const uint8_t *)&amp;hdr, sizeof(hdr));<br>diff --git a/h=
w/pci/pci.c b/hw/pci/pci.c<br>index c15f2b9f084..26003f2b4df 100644<br>--- =
a/hw/pci/pci.c<br>+++ b/hw/pci/pci.c<br>@@ -2888,7 +2888,7 @@ void pci_qdev=
_property_add_specifics(DeviceClass *dc)<br>=C2=A0 =C2=A0 =C2=A0ObjectClass=
 *oc =3D OBJECT_CLASS(dc);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* The loadparm=
 property is only supported on s390x */<br>- =C2=A0 =C2=A0if (target_s390x(=
)) {<br>+ =C2=A0 =C2=A0if (target_s390x(target_info())) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0object_class_property_add_str(oc, &quot;loadparm&quot;,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_qd=
ev_property_get_loadparm,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0pci_qdev_property_set_loadparm);<br>diff --git a/hw/scs=
i/scsi-disk.c b/hw/scsi/scsi-disk.c<br>index a42f7d8e77d..31170e87a33 10064=
4<br>--- a/hw/scsi/scsi-disk.c<br>+++ b/hw/scsi/scsi-disk.c<br>@@ -3190,7 +=
3190,7 @@ static void scsi_property_add_specifics(DeviceClass *dc)<br>=C2=
=A0 =C2=A0 =C2=A0ObjectClass *oc =3D OBJECT_CLASS(dc);<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0/* The loadparm property is only supported on s390x */<br>- =
=C2=A0 =C2=A0if (target_s390x()) {<br>+ =C2=A0 =C2=A0if (target_s390x(targe=
t_info())) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_class_property_add=
_str(oc, &quot;loadparm&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0scsi_property_get_loadparm,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scsi_property_set_loadparm);<b=
r>diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c<br=
>index a06cbf3c646..3d747b470cc 100644<br>--- a/hw/vfio/migration-multifd.c=
<br>+++ b/hw/vfio/migration-multifd.c<br>@@ -54,7 +54,7 @@ bool vfio_load_c=
onfig_after_iter(VFIODevice *vbasedev)<br>=C2=A0 =C2=A0 =C2=A0 * See commit=
 d329f5032e17 (&quot;vfio: Move the saving of the config space to<br>=C2=A0=
 =C2=A0 =C2=A0 * the right place in VFIO migration&quot;).<br>=C2=A0 =C2=A0=
 =C2=A0 */<br>- =C2=A0 =C2=A0return target_base_arm();<br>+ =C2=A0 =C2=A0re=
turn target_base_arm(target_info());<br>=C2=A0}<br>=C2=A0<br>=C2=A0/* type =
safety */<br>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<b=
r>index 2881cec72d9..3383af64859 100644<br>--- a/hw/virtio/vhost-user.c<br>=
+++ b/hw/virtio/vhost-user.c<br>@@ -2631,7 +2631,7 @@ static int vhost_user=
_backend_init(struct vhost_dev *dev, void *opaque,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const uint64_t vhost_user_max_ram_slots =3D target_base_pp=
c() ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t vhost_us=
er_max_ram_slots =3D target_base_ppc(target_info()) ?<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SPAPR_MAX_RAM_SLOTS : VHOST_US=
ER_MAX_RAM_SLOTS;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u-&gt;=
user-&gt;memory_slots =3D MIN(ram_slots, vhost_user_max_ram_slots);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>diff --git a/include/qemu/target-info-i=
mpl.h b/include/qemu/target-info-impl.h<br>index cf42aabbc8b..61404baa4b5 1=
00644<br>--- a/include/qemu/target-info-impl.h<br><br><br>any way, we can w=
ait the following pull to be merged first<br><br>[PULL 00/51] Misc HW/accel=
 patches for 2026-09-03<br><a href=3D"https://patchew.org/QEMU/202609031039=
36.62355-1-philmd@oss.qualcomm.com/" target=3D"_blank">https://patchew.org/=
QEMU/20260903103936.62355-1-philmd@oss.qualcomm.com/</a><br><br><br>and a b=
etter way to deal with it would be appreciated.</div><div dir=3D"ltr"><br><=
/div><div>I also have patches for riscv needs this.</div><div dir=3D"ltr"><=
br></div><div dir=3D"ltr"><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div></div>

--000000000000406c04065a96d866--

