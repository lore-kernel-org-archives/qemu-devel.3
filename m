Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441DAEE6B45
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQ5G-0004C0-4Z; Fri, 06 Feb 2026 12:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voQ5E-0004BX-14
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:57:32 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1voQ5C-0007ZQ-4B
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:57:31 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-663170b9472so1416728eaf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770400648; cv=none;
 d=google.com; s=arc-20240605;
 b=WBRO65pdcgaeLLA2X60EbPAQzL8FZ8LnVBBgit/lJoH002Dqfi1PctCyiQN6eLq0Fe
 6mnsfrCaw3zpedLnV0UDZ8oVBphxkbbrH8F4HbL3pOoqZ0YdNynMicER4zK3xnAQdF7F
 c+ZpFhRr3YwzAYQCBnRZyrp4DH2ybwa83KATvoozeayN23oeA62Ez/AJJyYAxkt12LMg
 qy4wt/PefU3Wf4ApKLfpH4cxcdfcaUnbxSVecWqe21CesivHVRZ3qw1TRxxepvROTe/Y
 M19Jx8uNJooLlg/aFuqXb4Gd0nbKF93fNGLOmN9Yoj1MtMhHGilXTq6trklZk3AoH/JQ
 QKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0YBih/ZicORW04UORhc/Z/2Kq8EF4UlrY2jP5IEB4O0=;
 fh=s9TmceJyPzTYuZ9yDMeO/HCEH8m+AE5Vpu9ovICunJo=;
 b=i1+DXR7v/ZUmzpOTqOIiPJrQDAg5r9edBlOD+4TijTECyou6mjQyWed4zqv8oqPqBq
 T28DnNdfRtWCXXtL3R4MYrisVHzJiCOqZRUra6eZSVXQVsRC3Px2Xfr7jdas5JOt5n22
 mO8elD/RX64aj9ZM/eNiYXz+IayPg8AQtsY+zb9OAzvQ+jAxnyBGGX734BX5XzXxeciN
 TuC4SkxvA+JxoAhjKMDPB5g/1Q9r4byl6MTB3EPYGaE6jy05ph9Kyojgn8iKubEJROIe
 AdWLtGjiuVsnD/YnRKjYu08yH4yxgMRZMu9m01Ao3obNDE43v/R5/ku7rJhWX0aldjUt
 BXnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770400648; x=1771005448; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YBih/ZicORW04UORhc/Z/2Kq8EF4UlrY2jP5IEB4O0=;
 b=Rm+aJd+0lLTu13wdAiulseLWyGFuIV7pbD/dUIvM56E+VrPVlMd1TEPesaro/Dj/nd
 7Z2rP81143h9xz5r4MHWy2ydtL2hwi65wsNPuirb8kIW79+xUqV5AMkSHb9ZvGLsw5b8
 NUBEaVCB13Qat+EgDsQCNzIAHVapaytlueTrj6l2A/GverY0bOOwbvb2vlgSDSSdxKGR
 FwSZri7lhRgUgk/kxaoD04LwWfDQ60SqMRO31cNkH+If969+Ri4x0ecHKrXvMj/qidHa
 bMGmuRTBkHg/Mt+TUeu5enNLS1j0U0G+2ACHzul/aYICI/e95A37keEoAuqrJscPsip7
 1ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400648; x=1771005448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0YBih/ZicORW04UORhc/Z/2Kq8EF4UlrY2jP5IEB4O0=;
 b=CPEYKc0VbCFUfA5VMMvjiyNthzn/nf+U3yW+v/RSZObGW//Iao22WzIbx54RLiWHqD
 +zPOMEuAjkDbSVpEc0rOJ0s6eIyNgrl22AABubLXN2P2fRJxXUAzhZdHxJXWJdAEeMQk
 9C/jLzc/73rbWBpTWFbRtQgjtbnDbn4SiWFq4mziMEDzgSln+KVzIGfPhMwS2ERYlUy0
 zxQCnS8v7RSJVKKO2YyuxCkEBQZoDz9yUUQpwkmL14sQqlm39dnzk0oKkAJ+1l8B7Y/M
 c8V3PTv2xwcx4d5tzkkfhcCNFg1NM7n3QyecKsHW7KP8aKl/ykfBqVxfGYmZ915gWHxs
 66/w==
X-Gm-Message-State: AOJu0Yx1mLMHwFDqdV5QPOsjbqoh3WGi0QtCFt/LDzYCK665pBe2fN1Z
 4XQa46IyHlQNcYn8VJq1mL6lXkyHTbTICag/zPxJUkU9K8NUAGU+PuRHSkSeRSgH8kE2xFsqH25
 n+6CANf63b2JzUyj6dUy7hzIBnOGCKxs=
X-Gm-Gg: AZuq6aJX94O2ahrrUqu3bzU4cn2LZSsK9oBK6I1Ir34swCn9NrOiefsyTcYZBJ7m3Ww
 vZE1MXP6pdfbt64Zdu8gxhxMHYbtHtbDsjZJuvwL6ikK69W1VOOj/XlnPq9X2jRVXNxe9v1FE5L
 2bCV75+Ll+OUJnj2TIAbUP+GfbRQri+IZY5SYHQIVHPs8v0be4QZVh/9ceKEZWahfbIsvt5Tom7
 CORMAgTNTJH4DECvM4/zDkOzPuzOMy+nn10pBofDfA/cfdOr8rn4SlcwmArFzwAIcorHaI9ilID
 ErXO7xo=
X-Received: by 2002:a05:6820:207:b0:662:fd74:61d5 with SMTP id
 006d021491bc7-66d09abf9b4mr1479918eaf.3.1770400648267; Fri, 06 Feb 2026
 09:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-24-ruslichenko.r@gmail.com>
 <aYUAWw9Rfuu7KWjA@redhat.com>
In-Reply-To: <aYUAWw9Rfuu7KWjA@redhat.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 6 Feb 2026 18:57:16 +0100
X-Gm-Features: AZwV_QhmBnAMee9tSiOrObNARSNoNehaIHvvXYS2fjqFH_Wiz1BvEWDcjz4ULQU
Message-ID: <CAN-aV1E1D_8Q9hCR4OBXx0ZU2uziiQ3jN05aPTUwm-AmFs9=QA@mail.gmail.com>
Subject: Re: [PATCH 23/29] system: Introduce -sync-quantum command line option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com, 
 Ruslan_Ruslichenko@epam.com, Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 5, 2026 at 9:41=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 08:58:18PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > Add a new global option '-sync-quantum' to specify the maximum time
> > interval, in nanoseconds, between synchronizations with remote peers.
>
> Again, we don't really want to introduced new top level command
> line options, so try to find an existing place that's suitable
> to fit this in, perhaps a prop -machine.
>

Understood, not sure machine options are applicable here,
but encapsulating it within remote-port itself may be possible. I will
investigate it for v2.

> >
> > In co-simulation environments (such as QEMU coupled with a SystemC
> > simulator), time must be synchronized periodically to ensure functional
> > accuracy. The 'sync-quantum' defines the maximum amount of time QEMU
> > can simulate ahead of its remote peers before a mandatory synchronizati=
on
> > event (sync packet) occurs.
> >
> > This value is stored in the global 'global_sync_quantum' variable and
> > serves as a default hint for device models and Remote Port instances
> > to manage their simulation time.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  include/system/system.h |  2 ++
> >  qemu-options.hx         | 11 +++++++++++
> >  system/vl.c             |  8 ++++++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/include/system/system.h b/include/system/system.h
> > index 0cd012004d..f187544147 100644
> > --- a/include/system/system.h
> > +++ b/include/system/system.h
> > @@ -59,6 +59,8 @@ extern MlockState mlock_state;
> >
> >  extern const char *machine_path;
> >
> > +extern uint64_t global_sync_quantum;
> > +
> >  #define MAX_OPTION_ROMS 16
> >  typedef struct QEMUOptionRom {
> >      const char *name;
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index b7dd2a64f0..8ef0c57507 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -765,6 +765,17 @@ SRST
> >      Preallocate memory when using -mem-path.
> >  ERST
> >
> > +DEF("sync-quantum", HAS_ARG, QEMU_OPTION_sync_quantum,
> > +    "-sync-quantum Max time between synchroniation, nanoseconds.\n",
> > +    QEMU_ARCH_ALL)
> > +SRST
> > +``-sync-quantum val``
> > +    Maximum time between synchronization <val>.
> > +    This value is used to drive periodic synchronization with remote p=
ort peers.
> > +    It is also used to set device models sync-quantum properties contr=
olling
> > +    the maximum amount of ahead of time simulation that is prefered (o=
nly a hint).
> > +ERST
> > +
> >  DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
> >      "-machine-path DIR A directory in which to create machine nodes\n"=
,
> >      QEMU_ARCH_ALL)
> > diff --git a/system/vl.c b/system/vl.c
> > index 4750b1cf69..467646c3ff 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -182,6 +182,7 @@ static QemuPluginList plugin_list =3D QTAILQ_HEAD_I=
NITIALIZER(plugin_list);
> >  static BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bd=
o_queue);
> >  static bool nographic =3D false;
> >  static int mem_prealloc; /* force preallocation of physical target mem=
ory */
> > +uint64_t global_sync_quantum;
> >  const char *machine_path;
> >  static const char *vga_model =3D NULL;
> >  static DisplayOptions dpy;
> > @@ -3129,6 +3130,13 @@ void qemu_init(int argc, char **argv)
> >              case QEMU_OPTION_mem_prealloc:
> >                  mem_prealloc =3D 1;
> >                  break;
> > +            case QEMU_OPTION_sync_quantum:
> > +                if (qemu_strtou64(optarg, &optarg, 10,
> > +                                  &global_sync_quantum)) {
> > +                    error_report("failed to parse sync_quantum");
> > +                    exit(1);
> > +                }
> > +                break;
> >              case QEMU_OPTION_machine_path:
> >                  machine_path =3D optarg;
> >                  break;
> > --
> > 2.43.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--
BR,
Ruslan

