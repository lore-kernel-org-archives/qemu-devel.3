Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E526D59D94
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 10:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFszh-0006Lx-B2; Tue, 26 Nov 2024 05:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tFszg-0006Lo-09
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tFszd-0001dz-QG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 05:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732617628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q26dCdPaeEt/civXaHfjy+FWm4NoGEeA2s33YCkVXzc=;
 b=hJCy5tX5LXjgV5VtBGFYx0XDcw5Yv7GwQDQr7zVMoUN8NRIH9FQccKsFlnTGrvB3A/lutb
 PbkUE+CgQorE8ZQ12Tptq0GD1Gg/yyngSsnJ4xkBQuHEV94FwxTshv3KttOn/0+ikx7co0
 ZCYWG/WtAEBBG6gmxKbOKhU1POnvvl8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-miCr5n-SOwCtrkJPJ5By-Q-1; Tue, 26 Nov 2024 05:40:23 -0500
X-MC-Unique: miCr5n-SOwCtrkJPJ5By-Q-1
X-Mimecast-MFC-AGG-ID: miCr5n-SOwCtrkJPJ5By-Q
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d41a460386so85331386d6.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 02:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732617622; x=1733222422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q26dCdPaeEt/civXaHfjy+FWm4NoGEeA2s33YCkVXzc=;
 b=JZPaQHFK3RzbT5xiUbZukO7WMgS/unn/WC+b6zU0mWvJvPSF2f1U3UsxhBDlm34fJ6
 Vaqx8n4VJyfVEzinr43mvy2OsBoxTfuomD3bc7qx8JmRjTbAsiiGgTd8pdhudtyNWQJ+
 xEaea5Gb1Jr3foQV8FBczebZI4rAOVnaA8AXeW711Aoxe7DMfZdt8ALtt9i/GeIFWhf5
 WacrUlwS1SJ/1tA01gy+z5IrOwfXMINNfVClTTr/TmKBUD+75vFL/bLIuxuzZdsWfMjA
 a5IpvmQpmi3BhKUXq2G4xNLyjKVxuUfngWAgYs0So5wDHAr2l7wyaHaX2nNVNzqp1Nqh
 R8MQ==
X-Gm-Message-State: AOJu0Ywbfi5zlqOa8XNolfrh+HdK5Jd0GSL/HalrtmuyiANTGknZEtmX
 +goBhcbw6wSo8Mz+6G8kROTj3ao10aWEEs3SKTpoHcTuOe6IfQ/tLjBC6V63MjXcXn/VuvZ5Ett
 WwZ3LYmH5RyzMVYdQyNeALBK3BuWo23qC7Em8mVUBK41WGZIrrE1TRY5zzIiJi30jUCUKRUUphr
 M5L4dvqbk9KKTsdcc7vpRQTF88yKI=
X-Gm-Gg: ASbGncseli5nAolo0j0bUQR2VxervXBUykjlV3Nd7JNl9BqiV3LNRUg/ZxMHij007ki
 vi7MxWP1W3JZoImzqHux4kj8EjbqG0n6mdA==
X-Received: by 2002:a05:6214:21eb:b0:6d4:1a42:8f06 with SMTP id
 6a1803df08f44-6d450adde12mr271445376d6.0.1732617622086; 
 Tue, 26 Nov 2024 02:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELcVJl/vaLvNFebBNRa5GdUa/I2FJBlrRNkfHCetsR6DQPIMpuvPqJ/JtEiFUCIuwzPfeOG+ZsJt4PMokmC3k=
X-Received: by 2002:a05:6214:21eb:b0:6d4:1a42:8f06 with SMTP id
 6a1803df08f44-6d450adde12mr271445176d6.0.1732617621714; Tue, 26 Nov 2024
 02:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20241002100634.162499-2-jean-louis@dupond.be>
 <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
 <33d6a951-033d-4827-9d85-88fba69bf839@dupond.be>
 <CAPMcbCrkzq3dGSJBkYZ_bU8qYTvXDokgJGkh563gg8OHGqB1wQ@mail.gmail.com>
 <25723cba-8c60-401e-8b9a-731430f0970d@dupond.be>
In-Reply-To: <25723cba-8c60-401e-8b9a-731430f0970d@dupond.be>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 26 Nov 2024 12:40:10 +0200
Message-ID: <CAPMcbCpUvrZ8ArtgZe69SygqWJ79h8syotSxfgLVjzy0VKss4A@mail.gmail.com>
Subject: Re: [PATCH] qga: skip bind mounts in fs list
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000dfc8730627ce790e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

--000000000000dfc8730627ce790e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

I will merge it into the next QEMU release.

On Mon, Oct 28, 2024 at 2:15=E2=80=AFPM Jean-Louis Dupond <jean-louis@dupon=
d.be>
wrote:

> Hi Konstantin,
>
> Thanks for your response.
> What I observed was when running CloudLinux is that with a /tmp on a loop
> device, is that the underlying fs was first freezed, and then the /tmp wa=
s
> getting a freeze call.
> But this was hanging, because it couldn't freeze as the underlying fs was
> already freezed.
>
> So the whole system became unresponsive expect if you send a unfreeze via
> sysrq.
>
> Build a qemu-ga with this patch included, and then it worked fine.
> Because it skips the bind mounts and therefor made sure that the loop
> device was first freezed and afterwards the underlying fs.
> Which works fine :)
>
> I did not see real kernel crashes, so that was not debugged/tested.
>
> Thanks
> Jean-Louis
> On 28/10/2024 11:57, Konstantin Kostiuk wrote:
>
> Hi Jean-Louis,
>
> Thanks for your patch. I hope next week, I will test and review this
> patch.
>
> Just a question, did you have a chance to test that this patch fix kernel
> crash?
>
> Best Regards,
> Konstantin Kostiuk.
>
>
> On Fri, Oct 25, 2024 at 1:06=E2=80=AFPM Jean-Louis Dupond <jean-louis@dup=
ond.be>
> wrote:
>
>> On 9/10/2024 10:34, Jean-Louis Dupond wrote:
>> > On 2/10/2024 12:06, Jean-Louis Dupond wrote:
>> >> The filesystem list in build_fs_mount_list should skip bind mounts.
>> >> This because we end up in locking situations when doing fsFreeze. Lik=
e
>> >> mentioned in [1] and [2].
>> >>
>> >> Next to that, the build_fs_mount_list call did a fallback via
>> >> build_fs_mount_list_from_mtab if mountinfo did not exist.
>> >> There it skipped bind mounts, but this is broken for newer OS.
>> >> This as mounts does not return the path of the bind mount but the
>> >> underlying dev/partition, so S_ISDIR will never return true in
>> >> dev_major_minor call.
>> >>
>> >> This patch simply checks the existing devmajor:devminor tuple in the
>> >> mounts, and if it already exists, this means we have the same devices
>> >> mounted again, a bind mount. So skip this.
>> >>
>> >> Same approach is used in open-vm-tools [3].
>> >>
>> >> [1]: https://gitlab.com/qemu-project/qemu/-/issues/592
>> >> [2]: https://gitlab.com/qemu-project/qemu/-/issues/520
>> >> [3]:
>> >>
>> https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c9=
45af1df22a8ab58
>> >>
>> >> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> >> ---
>> >>   qga/commands-linux.c | 25 +++++++++++++++++++++++++
>> >>   1 file changed, 25 insertions(+)
>> >>
>> >> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> >> index 51d5e3d927..426b040ab8 100644
>> >> --- a/qga/commands-linux.c
>> >> +++ b/qga/commands-linux.c
>> >> @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,
>> >>       return -1;
>> >>   }
>> >>   +/*
>> >> + * Check if we already have the devmajor:devminor in the mounts
>> >> + * If thats the case return true.
>> >> + */
>> >> +static bool dev_exists(FsMountList *mounts, unsigned int devmajor,
>> >> unsigned int devminor)
>> >> +{
>> >> +    FsMount *mount;
>> >> +
>> >> +    QTAILQ_FOREACH(mount, mounts, next) {
>> >> +        if (mount->devmajor =3D=3D devmajor && mount->devminor =3D=
=3D
>> >> devminor) {
>> >> +            return true;
>> >> +        }
>> >> +    }
>> >> +    return false;
>> >> +}
>> >> +
>> >>   static bool build_fs_mount_list_from_mtab(FsMountList *mounts,
>> >> Error **errp)
>> >>   {
>> >>       struct mntent *ment;
>> >> @@ -89,6 +105,10 @@ static bool
>> >> build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
>> >>               /* Skip bind mounts */
>> >>               continue;
>> >>           }
>> >> +        if (dev_exists(mounts, devmajor, devminor)) {
>> >> +            /* Skip already existing devices (bind mounts) */
>> >> +            continue;
>> >> +        }
>> >>             mount =3D g_new0(FsMount, 1);
>> >>           mount->dirname =3D g_strdup(ment->mnt_dir);
>> >> @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts,
>> >> Error **errp)
>> >>               }
>> >>           }
>> >>   +        if (dev_exists(mounts, devmajor, devminor)) {
>> >> +            /* Skip already existing devices (bind mounts) */
>> >> +            continue;
>> >> +        }
>> >> +
>> >>           mount =3D g_new0(FsMount, 1);
>> >>           mount->dirname =3D g_strdup(line + dir_s);
>> >>           mount->devtype =3D g_strdup(dash + type_s);
>> >
>> >
>> > Ping + add kkostiuk@redhat.com as I missed him in the initial mail.
>> >
>>
>> Any chance on a review or getting it merged?
>> Think it's a good (of course ;)) improvement.
>>
>>

--000000000000dfc8730627ce790e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><d=
iv><br></div><div>I will merge it into the next QEMU release. <br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Oct 28, 2024 at 2:15=E2=80=AFPM Jean-Louis Dupond &lt;<a href=3D"mailt=
o:jean-louis@dupond.be">jean-louis@dupond.be</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p>Hi Konstantin,</p>
    <p>Thanks for your response.<br>
      What I observed was when running CloudLinux is that with a /tmp on
      a loop device, is that the underlying fs was first freezed, and
      then the /tmp was getting a freeze call.<br>
      But this was hanging, because it couldn&#39;t freeze as the underlyin=
g
      fs was already freezed.<br>
      <br>
      So the whole system became unresponsive expect if you send a
      unfreeze via sysrq.<br>
      <br>
      Build a qemu-ga with this patch included, and then it worked fine.<br=
>
      Because it skips the bind mounts and therefor made sure that the
      loop device was first freezed and afterwards the underlying fs.<br>
      Which works fine :)<br>
      <br>
      I did not see real kernel crashes, so that was not
      debugged/tested.<br>
      <br>
      Thanks<br>
      Jean-Louis<br>
    </p>
    <div>On 28/10/2024 11:57, Konstantin Kostiuk
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Hi Jean-Louis,</div>
        <div><br>
        </div>
        <div>Thanks for your patch. I hope next week, I will test and
          review this patch. <br>
        </div>
        <div><br>
        </div>
        <div>Just a question, did you have a chance to test that this
          patch fix kernel crash? <br>
        </div>
        <div><br>
        </div>
        <div>
          <div>
            <div dir=3D"ltr" class=3D"gmail_signature">
              <div dir=3D"ltr">
                <div>Best Regards,</div>
                <div>Konstantin Kostiuk.</div>
              </div>
            </div>
          </div>
          <br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 25, 2024 at
          1:06=E2=80=AFPM Jean-Louis Dupond &lt;<a href=3D"mailto:jean-loui=
s@dupond.be" target=3D"_blank">jean-louis@dupond.be</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          9/10/2024 10:34, Jean-Louis Dupond wrote:<br>
          &gt; On 2/10/2024 12:06, Jean-Louis Dupond wrote:<br>
          &gt;&gt; The filesystem list in build_fs_mount_list should
          skip bind mounts.<br>
          &gt;&gt; This because we end up in locking situations when
          doing fsFreeze. Like<br>
          &gt;&gt; mentioned in [1] and [2].<br>
          &gt;&gt;<br>
          &gt;&gt; Next to that, the build_fs_mount_list call did a
          fallback via<br>
          &gt;&gt; build_fs_mount_list_from_mtab if mountinfo did not
          exist.<br>
          &gt;&gt; There it skipped bind mounts, but this is broken for
          newer OS.<br>
          &gt;&gt; This as mounts does not return the path of the bind
          mount but the<br>
          &gt;&gt; underlying dev/partition, so S_ISDIR will never
          return true in<br>
          &gt;&gt; dev_major_minor call.<br>
          &gt;&gt;<br>
          &gt;&gt; This patch simply checks the existing
          devmajor:devminor tuple in the<br>
          &gt;&gt; mounts, and if it already exists, this means we have
          the same devices<br>
          &gt;&gt; mounted again, a bind mount. So skip this.<br>
          &gt;&gt;<br>
          &gt;&gt; Same approach is used in open-vm-tools [3].<br>
          &gt;&gt;<br>
          &gt;&gt; [1]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/i=
ssues/592" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/issues/592</a><br>
          &gt;&gt; [2]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/i=
ssues/520" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/issues/520</a><br>
          &gt;&gt; [3]: <br>
          &gt;&gt; <a href=3D"https://github.com/vmware/open-vm-tools/commi=
t/d58847b497e212737007958c945af1df22a8ab58" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/vmware/open-vm-tools/commit/d58847b497e21273700795=
8c945af1df22a8ab58</a><br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Jean-Louis Dupond &lt;<a href=3D"mailto:j=
ean-louis@dupond.be" target=3D"_blank">jean-louis@dupond.be</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt; =C2=A0 qga/commands-linux.c | 25 +++++++++++++++++++++++=
++<br>
          &gt;&gt; =C2=A0 1 file changed, 25 insertions(+)<br>
          &gt;&gt;<br>
          &gt;&gt; diff --git a/qga/commands-linux.c
          b/qga/commands-linux.c<br>
          &gt;&gt; index 51d5e3d927..426b040ab8 100644<br>
          &gt;&gt; --- a/qga/commands-linux.c<br>
          &gt;&gt; +++ b/qga/commands-linux.c<br>
          &gt;&gt; @@ -59,6 +59,22 @@ static int dev_major_minor(const
          char *devpath,<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;<br>
          &gt;&gt; =C2=A0 }<br>
          &gt;&gt; =C2=A0 +/*<br>
          &gt;&gt; + * Check if we already have the devmajor:devminor in
          the mounts<br>
          &gt;&gt; + * If thats the case return true.<br>
          &gt;&gt; + */<br>
          &gt;&gt; +static bool dev_exists(FsMountList *mounts, unsigned
          int devmajor, <br>
          &gt;&gt; unsigned int devminor)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0 FsMount *mount;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(mount, mounts, next) =
{<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mount-&g=
t;devmajor =3D=3D devmajor
          &amp;&amp; mount-&gt;devminor =3D=3D <br>
          &gt;&gt; devminor) {<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return true;<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0 return false;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; =C2=A0 static bool
          build_fs_mount_list_from_mtab(FsMountList *mounts, <br>
          &gt;&gt; Error **errp)<br>
          &gt;&gt; =C2=A0 {<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mntent *ment;<br>
          &gt;&gt; @@ -89,6 +105,10 @@ static bool <br>
          &gt;&gt; build_fs_mount_list_from_mtab(FsMountList *mounts,
          Error **errp)<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip bind mounts */<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_exis=
ts(mounts, devmajor, devminor))
          {<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Skip already existing devices (bind
          mounts) */<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
          &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mount =3D g_new0(FsMount, 1);<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ount-&gt;dirname =3D
          g_strdup(ment-&gt;mnt_dir);<br>
          &gt;&gt; @@ -172,6 +192,11 @@ bool
          build_fs_mount_list(FsMountList *mounts, <br>
          &gt;&gt; Error **errp)<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
<br>
          &gt;&gt; =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (d=
ev_exists(mounts, devmajor,
          devminor)) {<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Skip already existing devices (bind
          mounts) */<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;<br>
          &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
          &gt;&gt; +<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ount =3D g_new0(FsMount, 1);<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ount-&gt;dirname =3D g_strdup(line + dir_s);<br>
          &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ount-&gt;devtype =3D g_strdup(dash +
          type_s);<br>
          &gt;<br>
          &gt;<br>
          &gt; Ping + add <a href=3D"mailto:kkostiuk@redhat.com" target=3D"=
_blank">kkostiuk@redhat.com</a> as I
          missed him in the initial mail.<br>
          &gt;<br>
          <br>
          Any chance on a review or getting it merged?<br>
          Think it&#39;s a good (of course ;)) improvement.<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </div>

</blockquote></div>

--000000000000dfc8730627ce790e--


