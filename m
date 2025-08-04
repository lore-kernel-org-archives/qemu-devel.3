Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87751C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiveP-0008FI-Tp; Mon, 04 Aug 2025 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengnici@gmail.com>)
 id 1uirte-0006c9-E4
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:54:22 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhengnici@gmail.com>)
 id 1uirtb-0001Xl-S1
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:54:22 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71a3935fa8dso21677297b3.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754301258; x=1754906058; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d35v01zl8S6rDQ3Kca2SzSIHkB/du7cfCRcpcWcGXhM=;
 b=TqfYEaeve0O7mp23yInxUXmlomaBbnlruw+3DRFWveJHTIUV/CT3++jW9g67lCtBNG
 eDW+4NXWlmI9icAR5eTBa6NEMqVce7r0XC69tdQDZ1iHpG2Qo1RlQMhUjMtKKOqiO5p5
 ZEAiLhpHl7KsDKDnU5Sr+wBdvm+oMh/GOpQaCu6wQGMQ9T9W7OnydvNPR3hYcBgxlD6+
 CGj7n9ukkps7DIsz27aBQA5csjfySzP/DdlWUJKmJ+VI33mJlBU+FITc6JnQCXovwlYA
 ZA2VyKH34GIw2vzqJjtTxLHWAjNQXEF58eEdkZeOxFIeGD1w35jkr0B+7pC03hgpwRSg
 qQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754301258; x=1754906058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d35v01zl8S6rDQ3Kca2SzSIHkB/du7cfCRcpcWcGXhM=;
 b=ZTVVKDILAyQMrSfur6cvZAVnU9HTprDiMAf1dPtWtDcGite3Da+rum+89gR2rm2s/S
 k02PUbU0xlgi+JE4X7G/KI2tPxsaMxHruiXqEPXoeILTd+TxQk8CFi2WIntZbOqTaLT3
 e3+9NwNP7o8ooDvw6Giu84OBFBS+ugN0fYg3MDPeeYuUzwfEz1iXIaX7t9SoiPJHjsxm
 OvPD6mV+AW9Vwjtde3QxDtnJefmR4JczRrTJj8pwM1HuIdJySJPWDEHefbmCGcAZoDl7
 tAENJuAgWXdV/f6F4O6+vCLUCHizi1l2suCdiOZXcLMTbVtNqBNt9xF0c/++iiFu88xE
 n8rw==
X-Gm-Message-State: AOJu0Yx3SZAHTOdSNwn0tZ6DKfPU6perZXN9KDHC2azhbl/nDPvYfV2s
 MOJs9CsioXz020Bi/UivQZQVWq29fIiKo+1gr2vTokiycmAsZSJQYFVTzTcS8DWiBwizu/Bd/s6
 EK4db4WV9xdxzt4BnjhnFxztqAvFGIXI=
X-Gm-Gg: ASbGncvNqMftJnodYP2WxpTWwC+l8WDJfh+3QzpSby/Y2upde+oC9ijxc3ueRf61hK0
 T2gbPegJiHe1VI6ud/+T6JHZkvGDe4OcWeUs29/zcLiTC5Kog1/jVXxdF7UhQGaO/8N/V4oaHZ4
 4Ns5PfMqEhjAI39Oer9SA5oOCISS4KBG1khNOLHfYMu+N7zBv8uJNTh7B4pQ8M9iqgzYwjjhkXI
 wDxuUadWJBS57G2IQ==
X-Google-Smtp-Source: AGHT+IFkHmSmQ70TMQ/FkmuIp8D6E+CLzwOFuNjM/YajXTMtp+/ZbNKgEDu2CMFwYVFD4NTeRsQG/9Mf/ahhow40ZBQ=
X-Received: by 2002:a05:690c:f91:b0:712:c14a:a388 with SMTP id
 00721157ae682-71b7ed127abmr100892717b3.7.1754301258458; Mon, 04 Aug 2025
 02:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250804074641.6021-1-zhengnici@gmail.com>
 <CAPMcbCq9d+fRVkZpWRQxOdyHOOTAgBT6dNE1VJdUhfAZTqr6hQ@mail.gmail.com>
In-Reply-To: <CAPMcbCq9d+fRVkZpWRQxOdyHOOTAgBT6dNE1VJdUhfAZTqr6hQ@mail.gmail.com>
From: nici zheng <zhengnici@gmail.com>
Date: Mon, 4 Aug 2025 17:54:07 +0800
X-Gm-Features: Ac12FXwFpEOpbOoqJzqN6oFji_8cdx1AoyY99Dv_FHfqBAAWN-NoNlF4Q7j5ee0
Message-ID: <CADAmGD-jPL=yd53oGLGZXV-DRuyfxPScc8E9-ZwaVRN8u7Lxdw@mail.gmail.com>
Subject: Re: [PATCH] qga: Fix error handling in system suspend mode causing
 libvirt to hold lock indefinitely
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, 
 panzerzheng <panzerzheng@tencent.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000056ec36063b87177d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=zhengnici@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Aug 2025 09:13:47 -0400
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

--00000000000056ec36063b87177d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kostiantyn,

Thank you again for your valuable feedback. I've conducted further
tests to address your questions, and here are the details:

1. Regarding exit code 1:
   I performed an experiment with the kernel configuration:

   When CONFIG_HIBERNATION is disabled in the kernel:
   [root@VM-23-13-opencloudos OpenCloudOS-Kernel]# grep -i HIBERNATION
/boot/config-6.6.47-12.oc9.x86_64
   CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
   # CONFIG_HIBERNATION is not set

   The /sys/power/state shows no "disk" support:
   [root@VM-0-94-opencloudos patch]# cat /sys/power/state
   freeze mem

   While "systemctl status systemd-hibernate" returns code 3:
   [root@VM-0-94-opencloudos patch]# systemctl status systemd-hibernate
   =E2=97=8B systemd-hibernate.service - Hibernate
    Loaded: loaded (/usr/lib/systemd/system/systemd-hibernate.service; stat=
ic)
        Active: inactive (dead)
      Docs: man:systemd-hibernate.service(8)
   [root@VM-0-94-opencloudos patch]# echo $?
   3

   The actual hibernation command returns code 1 due to kernel incompatibil=
ity:
   [root@VM-0-94-opencloudos patch]# systemctl hibernate
       Call to Hibernate failed: Sleep verb 'hibernate' is not
configured or configuration is not supported by kernel
   [root@VM-0-94-opencloudos patch]# echo $?
   1

   This confirms exit code 1 indicates actual hibernation support
failure in this scenario.

2. Regarding mode_supported logic:
   I understand your confusion about the check in
systemd_supports_mode(mode, &local_err). Another experiment
illustrates the issue:

   On a system with hibernation enabled:
   [opencloudos@VM-23-13-opencloudos ~]$ grep -i HIBERNATION
/boot/config-6.6.92+
   CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
   CONFIG_ARCH_HIBERNATION_HEADER=3Dy
   CONFIG_HIBERNATION=3Dy
   CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy

   /sys/power/state includes "disk":
   [opencloudos@VM-23-13-opencloudos ~]$ cat /sys/power/state
   freeze mem disk

   However, "systemctl status systemd-hibernate" still returns code 3
regardless of actual support:
   [opencloudos@VM-23-13-opencloudos ~]$ sudo systemctl status systemd-hibe=
rnate
   =E2=97=8B systemd-hibernate.service - Hibernate
        Loaded: loaded
(/usr/lib/systemd/system/systemd-hibernate.service; static)
        Active: inactive (dead)
          Docs: man:systemd-hibernate.service(8)

   [output truncated for brevity]

   [opencloudos@VM-23-13-opencloudos ~]$ echo $?
   3

   This shows "systemctl status" isn't reliable for determining
support. The actual execution result of "systemctl hibernate" is
necessary to accurately verify suspend-to-disk capability.

Thanks again for your patience and guidance. I'll revise the patch
accordingly and resubmit as v2.

Best regards,
panzerzheng


Kostiantyn Kostiuk <kkostiuk@redhat.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=B8=80 16:18=E5=86=99=E9=81=93=EF=BC=9A

>
>
> On Mon, Aug 4, 2025 at 10:47=E2=80=AFAM <zhengnici@gmail.com> wrote:
>
>> From: panzerzheng <panzerzheng@tencent.com>
>>
>> When "/sys/power/state" does not contain "disk", the operating system
>> does not support hibernation. Executing "sudo systemctl hibernate" will
>> return an exit code of 1 with the stderr output: "Call to Hibernate
>> failed:
>> Sleep verb 'hibernate' is not configured or configuration is not
>> supported by kernel".
>>
>
>> This patch adds handling for exit code 1 in the systemd_suspend function=
,
>> setting appropriate error messages when the kernel does not support
>> standby.
>> It also adds local_err handling in the guest_suspend function to set
>> mode_supported to false.
>>
>> Without these fixes, libvirt would hold the lock indefinitely.
>>
>> Signed-off-by: panzerzheng <panzerzheng@tencent.com>
>> ---
>>  qga/commands-linux.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> index 9e8a934b9a..26229396c3 100644
>> --- a/qga/commands-linux.c
>> +++ b/qga/commands-linux.c
>> @@ -1300,6 +1300,12 @@ static void systemd_suspend(SuspendMode mode,
>> Error **errp)
>>          return;
>>      }
>>
>> +    if ((status =3D=3D 1) && !local_err) {
>>
>
> Is there any documentation that explains that exit code =3D 1 is an error=
?
> If you look into systemd_supports_mode, you can see that exit code =3D 1 =
is
> detected
> as a supported mode.
>
>
>> +        error_setg(errp, "'systemctl %s' not suspend",
>> +                   systemctl_args[mode]);
>> +        return;
>> +    }
>> +
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>      } else {
>> @@ -1428,6 +1434,8 @@ static void guest_suspend(SuspendMode mode, Error
>> **errp)
>>
>>          if (!local_err) {
>>              return;
>> +        } else {
>> +            mode_supported =3D false;
>>          }
>>
>
> This is very confusing. We check that the mode is supported, but after
> running suspend,
> we find that it is unsupported. I think we should fix
> systemd_supports_mode instead.
>
> Also, setting mode_supported =3D false does not change anything.
> In the next step, we will check pmutils_supports_mode and
> linux_sys_state_supports_mode,
> and I think this check will pass, so we set mode_supported =3D true again=
.
>
> Best Regards,
> Kostiantyn Kostiuk.
>
>
>>      }
>>
>> --
>> 2.43.7
>>
>>

--00000000000056ec36063b87177d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><pre class=3D"gmail-container-_HmLba gmai=
l-language-plaintext" style=3D"outline:none;box-sizing:border-box;font-fami=
ly:ui-monospace,SFMono-Regular,&quot;SF Mono&quot;,Menlo,Consolas,&quot;Lib=
eration Mono&quot;,monospace;color:rgb(0,0,0);word-break:normal;line-height=
:1.5;margin:0px;overflow:auto;font-size:13.6px;border-radius:6px;padding:0p=
x;width:fit-content"><code class=3D"gmail-language-plaintext" style=3D"outl=
ine:none;box-sizing:border-box;background:transparent;border-radius:4px;col=
or:var(--code-block-code-color);font-size:13px;font-family:Menlo,Monaco,Con=
solas,&quot;Courier New&quot;,monospace;word-break:normal;word-spacing:norm=
al;line-height:1.5">Hi Kostiantyn,

Thank you again for your valuable feedback. I&#39;ve conducted further test=
s to address your questions, and here are the details:

1. Regarding exit code 1:
   I performed an experiment with the kernel configuration:
  =20
   When CONFIG_HIBERNATION is disabled in the kernel:
   [root@VM-23-13-opencloudos OpenCloudOS-Kernel]# grep -i HIBERNATION /boo=
t/config-6.6.47-12.oc9.x86_64=20
   CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
   # CONFIG_HIBERNATION is not set
  =20
   The /sys/power/state shows no &quot;disk&quot; support:
   [root@VM-0-94-opencloudos patch]# cat /sys/power/state
   freeze mem
  =20
   While &quot;systemctl status systemd-hibernate&quot; returns code 3:
   [root@VM-0-94-opencloudos patch]# systemctl status systemd-hibernate
   =E2=97=8B systemd-hibernate.service - Hibernate
    Loaded: loaded (/usr/lib/systemd/system/systemd-hibernate.service; stat=
ic)
        Active: inactive (dead)
      Docs: man:systemd-hibernate.service(8)
   [root@VM-0-94-opencloudos patch]# echo $?
   3
  =20
   The actual hibernation command returns code 1 due to kernel incompatibil=
ity:
   [root@VM-0-94-opencloudos patch]# systemctl hibernate
       Call to Hibernate failed: Sleep verb &#39;hibernate&#39; is not conf=
igured or configuration is not supported by kernel
   [root@VM-0-94-opencloudos patch]# echo $?
   1
  =20
   This confirms exit code 1 indicates actual hibernation support failure i=
n this scenario.

2. Regarding mode_supported logic:
   I understand your confusion about the check in systemd_supports_mode(mod=
e, &amp;local_err). Another experiment illustrates the issue:
  =20
   On a system with hibernation enabled:
   [opencloudos@VM-23-13-opencloudos ~]$ grep -i HIBERNATION /boot/config-6=
.6.92+=20
   CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
   CONFIG_ARCH_HIBERNATION_HEADER=3Dy
   CONFIG_HIBERNATION=3Dy
   CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy =20
  =20
   /sys/power/state includes &quot;disk&quot;:
   [opencloudos@VM-23-13-opencloudos ~]$ cat /sys/power/state
   freeze mem disk
  =20
   However, &quot;systemctl status systemd-hibernate&quot; still returns co=
de 3 regardless of actual support:
   [opencloudos@VM-23-13-opencloudos ~]$ sudo systemctl status systemd-hibe=
rnate
   =E2=97=8B systemd-hibernate.service - Hibernate
        Loaded: loaded (/usr/lib/systemd/system/systemd-hibernate.service; =
static)
        Active: inactive (dead)
          Docs: man:systemd-hibernate.service(8)
  =20
   [output truncated for brevity]
  =20
   [opencloudos@VM-23-13-opencloudos ~]$ echo $?
   3
  =20
   This shows &quot;systemctl status&quot; isn&#39;t reliable for determini=
ng support. The actual execution result of &quot;systemctl hibernate&quot; =
is necessary to accurately verify suspend-to-disk capability.

Thanks again for your patience and guidance. I&#39;ll revise the patch acco=
rdingly and resubmit as v2.

Best regards,
panzerzheng</code></pre></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">Kostiantyn Kostiuk &lt;<a hre=
f=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; =E4=BA=8E2025=
=E5=B9=B48=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=80 16:18=E5=86=99=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 4, 2025 at 10:47=E2=80=AFAM &lt;<=
a href=3D"mailto:zhengnici@gmail.com" target=3D"_blank">zhengnici@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: panzerzheng &lt;<a href=3D"mailto:panzerzheng@tencent.com" target=3D"=
_blank">panzerzheng@tencent.com</a>&gt;<br>
<br>
When &quot;/sys/power/state&quot; does not contain &quot;disk&quot;, the op=
erating system<br>
does not support hibernation. Executing &quot;sudo systemctl hibernate&quot=
; will<br>
return an exit code of 1 with the stderr output: &quot;Call to Hibernate fa=
iled:<br>
Sleep verb &#39;hibernate&#39; is not configured or configuration is not su=
pported by kernel&quot;.<br></blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
This patch adds handling for exit code 1 in the systemd_suspend function,<b=
r>
setting appropriate error messages when the kernel does not support standby=
.<br>
It also adds local_err handling in the guest_suspend function to set<br>
mode_supported to false.<br>
<br>
Without these fixes, libvirt would hold the lock indefinitely.<br>
<br>
Signed-off-by: panzerzheng &lt;<a href=3D"mailto:panzerzheng@tencent.com" t=
arget=3D"_blank">panzerzheng@tencent.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 9e8a934b9a..26229396c3 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1300,6 +1300,12 @@ static void systemd_suspend(SuspendMode mode, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if ((status =3D=3D 1) &amp;&amp; !local_err) {<br></blockquo=
te><div><br></div><div><div>Is there any documentation that explains that e=
xit code =3D 1 is an error?</div><div>If you look into systemd_supports_mod=
e, you can see that exit code =3D 1 is detected <br></div><div>as a support=
ed mode. </div></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;&#39;systemctl %s&#39; =
not suspend&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -1428,6 +1434,8 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Thi=
s is very confusing. We check that the mode is supported, but after running=
 suspend,<br> we find that it is unsupported. I think we should fix systemd=
_supports_mode instead. <br></div><div><br></div><div>Also, setting mode_su=
pported =3D false does not change anything. <br></div><div>In the next step=
, we will check pmutils_supports_mode and linux_sys_state_supports_mode,<br=
></div><div>and I think this check will pass, so we set mode_supported =3D =
true again. <br></div><div><br>Best Regards,<br>Kostiantyn Kostiuk.<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.43.7<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000056ec36063b87177d--

