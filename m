Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3EEC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XCQ-0003Oj-Lb; Mon, 07 Sep 2026 07:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XCO-0003OY-Eh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XCL-0003rM-OT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NUM7iOVsBPVhFHg+G7NDkQ30MHsuzs0bQJzxwZoxHM=;
 b=KdySMK9BmQrbGaCagSVzN3xm3oDrINQPccpZ2V9pQb8jte29Q20J+NCSBovvXnHsQLLxWZ
 6hN+Y/BNwTWJU1X3WegfJ59YqyKlGvrQMbpN67tcbkmhVWCD3qIqpDTvxup3rLasKwu8GQ
 CjzubMKyIROABYAdRcplU8Pl9dtSteE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-oiRFk4BTNOaN-x_2UmXqfA-1; Mon, 07 Sep 2026 07:07:32 -0400
X-MC-Unique: oiRFk4BTNOaN-x_2UmXqfA-1
X-Mimecast-MFC-AGG-ID: oiRFk4BTNOaN-x_2UmXqfA_1788779251
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso58897836d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779251; cv=none;
 d=google.com; s=arc-20260327;
 b=efKwkYyV1AkKc2VCNyS0DVBRMdhurcQBgq2uq6OqK8jDhN/AbITUqCPd5R3THe4XrL
 ja8XHG/rvpPxcQ7lgtD6cqsllT39ovjZSgPHjOyJVEoNqb+sP7+yOn5TT+3mIZZiLObn
 3PS/tAr1vXhBJ2J0mV2O0laMauu9uncMSdOuA/k3oE+jsboIU/T37x7XGUltAVEv/25k
 ZZ8Bu1R1xxpq35HI/DZcT8idNFz80Lx6sxZskbNVrYjQ1sitj7s5VyCpjofX4y2nYdQW
 w9/rxugezpuf7Up3e3OZlbqaF58MAZgqDuWt2btB2ggWjuffUFPBQ0fNOM+yPlC/CiET
 b5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0NUM7iOVsBPVhFHg+G7NDkQ30MHsuzs0bQJzxwZoxHM=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=gop8Y2QskfcxVyMucXXAuIsCC5bHAyECxW6oDBRiiXG8eDdcXiiZadJZH0gx/GGuA5
 EIshdKNHTD6tsvJ7xCvb+7r3JDRQ3PJr+BCTZ2FHyZKPv/k2IVQPtYg4ZZfm4YrJDAxy
 8zv9AxTFZWQTzeCXTXpYZnN5Y2ooUHCnMu+RNGfx5t9aajoA5TfWx5bddXBEHY1iXNdd
 PmsoQy4CLA2CZbR1FTeil6HgeJKsgxlW7F20++c85VoJgMIorQ0+KsbJgujU0yocuLUS
 csaxW5Vt0nF9B6sRyXDm+2ic+3RNTi6VRHK6TVrHkFsszqaml0rDw5+MLzNF6udJhgYT
 Z8ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779251; x=1789384051; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0NUM7iOVsBPVhFHg+G7NDkQ30MHsuzs0bQJzxwZoxHM=;
 b=tByFAqwiAEZ+WIaNSwEYOdsm9dGXpM2rg6j/2lL9/PHcEy6BWHYo9ha7VQ8dLfk2lq
 1E0HTGLtkPIkRe4dz/d50luxWLe3dL6RSpQN31qwSXlKihV2KNVA8KKERIna0xwIcE8c
 Zwu+Ah49AD1msQL97ZPUv6oQxCn3UWKPJT9J1Y3rC0doKBn/M+dPeJcO8ub/EdrnlWN3
 L0vcRzBrK3GgpDxTu4mPkEbQ//9uTtulXd1d+4kO2mGMt+blueAr5WjacOHLQnBnNj5l
 W9skm6iKtUEOOZlPwskFcQgOFPdss+0JXkUSlYte0epNSOU1LDAHEZurzQCl0Ep3Twy9
 5JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779251; x=1789384051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0NUM7iOVsBPVhFHg+G7NDkQ30MHsuzs0bQJzxwZoxHM=;
 b=aO9EigDo9Y0NWY5uQ04u1yhEZUDkCIGzlVYg5TFx9EswChmwEtMSFzNhlg932RBlsd
 y7cNDymsO915fkCIlCVkvFX9WHe8i8V0XKLZE4gIgf1SHE5GBWZ+WslylwGb9cWSNNH5
 fw4dhEEf/xwFtgzRzpAcAmhVCdUn8yyeai/KiV7zs9oGQjD/dt+G4dIgN0bs6ZWtTDNB
 9oXN5F32Dms3Y9MPrH4hkMHTtBY68o7I5LaBNqU2/8M6y8ZXBPJ5vGXEIA+FpZd2J9NH
 beko1IyGpD+8AkJbHSpvM/H+aePu+faga5tyojws99+Ipm8Xj3hzmv7HUnEUi1LmHpY1
 G37A==
X-Gm-Message-State: AFuF++mFAmMpVgumcP13jVH8wO3/LEpcXDqggED52fYF0w8AGwg7gr0A
 ohTsfXkFmUbMO47ssts8yryS8pU5wUBvVwHT0oX79rIyKuwpXC2aXexFdB4RghRLhJm9dQeru9i
 vj64ueVWF4HG3qwskogwGoWM2QqSMyEFg/Q0pEFDzD3OEjWJm07JbupLkMMPOR+ONs3dtgHocIT
 WVm3sdG9kb8rH/9UtQ5IZNeoTYhjkpvdM=
X-Gm-Gg: AYBFou37t/pgC3wg2EzytlV5JLuenQmnzK/KYUKIz5sWDPa6QamLODpTwMIlZMmkvlO
 7k+jAADwrQn7jVru4dGPuMyPOxIrRtdaPZcVeRZr4IW81isn6x7pOtNZOv8FulLfB9wIz8Vdqry
 7jmRGlrnS73UiyDvRBhUMARTUjntqlL8oIwlIpGoaa8R3r2Hi5rMwWh1Qwsko=
X-Received: by 2002:a05:6214:428d:b0:90e:96d1:7b95 with SMTP id
 6a1803df08f44-9103f0474a0mr302529316d6.24.1788779251244; 
 Mon, 07 Sep 2026 04:07:31 -0700 (PDT)
X-Received: by 2002:a05:6214:428d:b0:90e:96d1:7b95 with SMTP id
 6a1803df08f44-9103f0474a0mr302528176d6.24.1788779250615; Mon, 07 Sep 2026
 04:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-1-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-1-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:07:19 +0300
X-Gm-Features: AcwNN1XhDyX5GK6vSoDW1WunRn1uGzSH0s_-igScbg2lV7QRMqB79ioorESVBVE
Message-ID: <CAPMcbCoQa7GFX5-UFBjibce=7fTrYUs51KjrdCSxBq2PZ3X-oQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] qga/installer: preserve VssOption registry value
 across upgrades
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000d0d683065ae29f71"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000d0d683065ae29f71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>


On Mon, Sep 7, 2026 at 1:48=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The VssOption registry value was unconditionally written to 1 on every
> install, overwriting any administrator customization. Additionally, it
> was created even when VSS support was not being installed.
>
> Move VssOption into its own component guarded by the InstallVss
> preprocessor conditional. Use a RegistrySearch to read any existing
> value into the VSSOPTION_VALUE property (defaulting to #1 for fresh
> installs), and write it back via MSI property substitution so admin
> customizations survive upgrades.
>
> Update the registry_entries component GUID since its resource set
> changed.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2919
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/installer/qemu-ga.wxs | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
> index 32b8308728dc..5be19b211ccf 100644
> --- a/qga/installer/qemu-ga.wxs
> +++ b/qga/installer/qemu-ga.wxs
> @@ -31,6 +31,15 @@
>        />
>      <Media Id=3D"1" Cabinet=3D"qemu_ga.$(var.QEMU_GA_VERSION).cab"
> EmbedCab=3D"yes" />
>      <Property Id=3D"WHSLogo">1</Property>
> +    <?ifdef var.InstallVss?>
> +    <Property Id=3D"VSSOPTION_VALUE" Value=3D"#1">
> +      <RegistrySearch Id=3D"VssOptionSearch"
> +                      Root=3D"HKLM"
> +                      Key=3D"System\CurrentControlSet\Services\QEMU Gues=
t
> Agent VSS Provider"
> +                      Name=3D"VssOption"
> +                      Type=3D"raw" />
> +    </Property>
> +    <?endif?>
>      <Property Id=3D"ARPNOMODIFY" Value=3D"yes" Secure=3D"yes" />
>      <MajorUpgrade
>        DowngradeErrorMessage=3D"Error: A newer version of QEMU guest agen=
t
> is already installed."
> @@ -111,7 +120,7 @@
>                <File Id=3D"libpcre2_8_0.dll" Name=3D"libpcre2-8-0.dll"
> Source=3D"$(var.BIN_DIR)/libpcre2-8-0.dll" KeyPath=3D"yes" DiskId=3D"1"/>
>              </Component>
>            <?endif?>
> -          <Component Id=3D"registry_entries"
> Guid=3D"{D075D109-51CA-11E3-9F8B-000C29858960}">
> +          <Component Id=3D"registry_entries"
> Guid=3D"{62A2D9E2-B22F-410C-8E41-A0D9E653B944}">
>              <RegistryKey Root=3D"HKLM"
>
> Key=3D"Software\$(var.QEMU_GA_MANUFACTURER)\$(var.QEMU_GA_DISTRO)\Tools\Q=
emuGA">
>                <RegistryValue Type=3D"string" Name=3D"ProductID"
> Value=3D"fb0a0d66-c7fb-4e2e-a16b-c4a3bfe8d13b" />
> @@ -122,11 +131,16 @@
>                <RegistryValue Type=3D"integer" Name=3D"TypesSupported"
> Value=3D"7" />
>                <RegistryValue Type=3D"string" Name=3D"EventMessageFile"
> Value=3D"[qemu_ga_directory]qemu-ga.exe" />
>              </RegistryKey>
> +          </Component>
> +          <?ifdef var.InstallVss?>
> +          <Component Id=3D"vss_registry_option"
> Guid=3D"{75166af0-cdc9-423f-9a30-50bb59342b9b}">
>              <RegistryKey Root=3D"HKLM"
>                           Key=3D"System\CurrentControlSet\Services\QEMU
> Guest Agent VSS Provider">
> -              <RegistryValue Type=3D"integer" Name=3D"VssOption" Value=
=3D"1" />
> +              <!-- Type=3D"string" so MSI resolves [VSSOPTION_VALUE]; th=
e
> "#N" raw format produces a REG_DWORD. -->
> +              <RegistryValue Type=3D"string" Name=3D"VssOption"
> Value=3D"[VSSOPTION_VALUE]" KeyPath=3D"yes" />
>              </RegistryKey>
>            </Component>
> +          <?endif?>
>          </Directory>
>        </Directory>
>      </Directory>
> @@ -167,6 +181,7 @@
>        <ComponentRef Id=3D"libstdc++_6_lib" />
>        <ComponentRef Id=3D"qga_vss_dll" />
>        <ComponentRef Id=3D"qga_vss_tlb" />
> +      <ComponentRef Id=3D"vss_registry_option" />
>        <?endif?>
>        <ComponentRef Id=3D"gspawn-helper-console" />
>        <ComponentRef Id=3D"gspawn-helper" />
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000d0d683065ae29f71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D=
"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div></div></div><=
/div><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2026 at 1:48=E2=80=AFPM Marc-=
Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcan=
dre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">The VssOption registry value was unconditionally writt=
en to 1 on every<br>
install, overwriting any administrator customization. Additionally, it<br>
was created even when VSS support was not being installed.<br>
<br>
Move VssOption into its own component guarded by the InstallVss<br>
preprocessor conditional. Use a RegistrySearch to read any existing<br>
value into the VSSOPTION_VALUE property (defaulting to #1 for fresh<br>
installs), and write it back via MSI property substitution so admin<br>
customizations survive upgrades.<br>
<br>
Update the registry_entries component GUID since its resource set<br>
changed.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/2919=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/2919</a><br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/installer/qemu-ga.wxs | 19 +++++++++++++++++--<br>
=C2=A01 file changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs<br>
index 32b8308728dc..5be19b211ccf 100644<br>
--- a/qga/installer/qemu-ga.wxs<br>
+++ b/qga/installer/qemu-ga.wxs<br>
@@ -31,6 +31,15 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Media Id=3D&quot;1&quot; Cabinet=3D&quot;qemu_ga.$(=
var.QEMU_GA_VERSION).cab&quot; EmbedCab=3D&quot;yes&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Property Id=3D&quot;WHSLogo&quot;&gt;1&lt;/Property=
&gt;<br>
+=C2=A0 =C2=A0 &lt;?ifdef var.InstallVss?&gt;<br>
+=C2=A0 =C2=A0 &lt;Property Id=3D&quot;VSSOPTION_VALUE&quot; Value=3D&quot;=
#1&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;RegistrySearch Id=3D&quot;VssOptionSearch&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Root=3D&quot;HKLM&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Key=3D&quot;System\CurrentControlSet\Services\QEMU Guest Agent VSS Prov=
ider&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Name=3D&quot;VssOption&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Type=3D&quot;raw&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;/Property&gt;<br>
+=C2=A0 =C2=A0 &lt;?endif?&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Property Id=3D&quot;ARPNOMODIFY&quot; Value=3D&quot=
;yes&quot; Secure=3D&quot;yes&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;MajorUpgrade<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0DowngradeErrorMessage=3D&quot;Error: A newer ver=
sion of QEMU guest agent is already installed.&quot;<br>
@@ -111,7 +120,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;File Id=3D&quot;=
libpcre2_8_0.dll&quot; Name=3D&quot;libpcre2-8-0.dll&quot; Source=3D&quot;$=
(var.BIN_DIR)/libpcre2-8-0.dll&quot; KeyPath=3D&quot;yes&quot; DiskId=3D&qu=
ot;1&quot;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/Component&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;?endif?&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;Component Id=3D&quot;registry_entri=
es&quot; Guid=3D&quot;{D075D109-51CA-11E3-9F8B-000C29858960}&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;Component Id=3D&quot;registry_entri=
es&quot; Guid=3D&quot;{62A2D9E2-B22F-410C-8E41-A0D9E653B944}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RegistryKey Root=3D&quo=
t;HKLM&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Key=3D&quot;Software\$(var.QEMU_GA_MANUFACTURER)\$(var.QE=
MU_GA_DISTRO)\Tools\QemuGA&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RegistryValue Ty=
pe=3D&quot;string&quot; Name=3D&quot;ProductID&quot; Value=3D&quot;fb0a0d66=
-c7fb-4e2e-a16b-c4a3bfe8d13b&quot; /&gt;<br>
@@ -122,11 +131,16 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RegistryValue Ty=
pe=3D&quot;integer&quot; Name=3D&quot;TypesSupported&quot; Value=3D&quot;7&=
quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RegistryValue Ty=
pe=3D&quot;string&quot; Name=3D&quot;EventMessageFile&quot; Value=3D&quot;[=
qemu_ga_directory]qemu-ga.exe&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/RegistryKey&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/Component&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;?ifdef var.InstallVss?&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;Component Id=3D&quot;vss_registry_o=
ption&quot; Guid=3D&quot;{75166af0-cdc9-423f-9a30-50bb59342b9b}&quot;&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RegistryKey Root=3D&quo=
t;HKLM&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Key=3D&quot;System\CurrentControlSet\Services\QEMU Guest =
Agent VSS Provider&quot;&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;RegistryValue Type=3D=
&quot;integer&quot; Name=3D&quot;VssOption&quot; Value=3D&quot;1&quot; /&gt=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;!-- Type=3D&quot;stri=
ng&quot; so MSI resolves [VSSOPTION_VALUE]; the &quot;#N&quot; raw format p=
roduces a REG_DWORD. --&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;RegistryValue Type=3D=
&quot;string&quot; Name=3D&quot;VssOption&quot; Value=3D&quot;[VSSOPTION_VA=
LUE]&quot; KeyPath=3D&quot;yes&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/RegistryKey&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/Component&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;?endif?&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/Directory&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/Directory&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Directory&gt;<br>
@@ -167,6 +181,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ComponentRef Id=3D&quot;libstdc++_6_lib&quot=
; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ComponentRef Id=3D&quot;qga_vss_dll&quot; /&=
gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ComponentRef Id=3D&quot;qga_vss_tlb&quot; /&=
gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;ComponentRef Id=3D&quot;vss_registry_option&quot;=
 /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;?endif?&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ComponentRef Id=3D&quot;gspawn-helper-consol=
e&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ComponentRef Id=3D&quot;gspawn-helper&quot; =
/&gt;<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div></div>

--000000000000d0d683065ae29f71--


