Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F0C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC68B-0007mO-Dn; Mon, 05 May 2025 20:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uC689-0007k3-8j
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:25:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uC686-0001PG-Nu
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:25:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso6070974a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1746491148; x=1747095948;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXqNvK4OJA+etrSVJLqYxOQDa2KXhVaIPqRAU261ttc=;
 b=PNTe3Boh8kbGXtGzp62m/5RRD3xTEqIIslvNLVN7TVyIPSo9BfsnewAtEktEzdG/Dp
 yXcVcRaB6z4Q+HK6xfOtdxNK3uNJhjv65NjZneo5YY+KYCF8sTVmFB0bsqm513+xCxqE
 F8TTxvYCMMtIPy9z5ez1yG0LJe47ldWHAVQ9xkPh4MZPE8WXmHRHqbXGgKMdgxj80CyT
 +KFaAs5LOB+d06scnA7bmSSWrinT+1nx1szkrpd5LfbTNTq52HdR7759WYLTjPwcVBeu
 c+S9ooUZLjt1Qwun5hDKuenx3x25tyrs1pwvJGYyp8U0SwUeaO2+95rDcMl98/sDPri7
 J1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746491148; x=1747095948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXqNvK4OJA+etrSVJLqYxOQDa2KXhVaIPqRAU261ttc=;
 b=FHatQ/1RmJ0AUQ8o/B6RasEMYE/9QblW7A5XFxoCFL9ecns922KLwNVcAaLXkYHaOd
 VUvWaKOCCDTu16Z532P5P2HDk1YVBYJyh5qUTxFaVPkzMM1XJOLIAd8pqa34hezBnHZ0
 0zwQ1qPQJI9mVm3EKFxXGe6dazgpoFoEnVDviBXnwV4ZnTQcXaBVnQw9xuYJYj3FnnFV
 hyx5Amj1E8Mx+bubTFLTkq8jhyUgSLbrIzpFV8rHOTsclDK6LuCtclZ1MYKPDFbnx7YG
 VmgUv0Y96TFBCLAVNW4L1I8+jPAH6vk8xCCH+smhG5fb8QXiDAivovQKqkz2N4YIN4G0
 s3CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcEiDA7aXs6IjdZRc+mzk+5sK6J/mu+ZT5kPd3putlkSsq5ivKp/ih5eo+jeLjv22XTOIWdWfgt/Fi@nongnu.org
X-Gm-Message-State: AOJu0Yy9oFEYwQaMKt2F44WRVesXExQM+LiK1xkl9N8ELBzJRiu4DFp2
 RFsju/QWR9MiRlab3/45kA9K5YhDJDoDdVc3b6osTSn46ryP2tLf6J2CPE0uxm1cZJDmbTec0aQ
 lpYcnBSJxgCTpjlHg80e2aWwbeEgpXsnItvHSaw==
X-Gm-Gg: ASbGncsuQqmj1uFyWr2NRI/8uR7Ag9sXq4d2lDZn3RpC7Rq9EglTbY0QV0RFpIPItEW
 HQ+UP8I24gkX8TEbYSSCLLQm2aoS72RUIXZJ2CnLsqeznn60zbOkw4yJv9BELsB3oe+z0ZdpTll
 kXqWCEYEOc+T0FhboGoADqFA==
X-Google-Smtp-Source: AGHT+IG29FXXg8BWj7yzh2hiivHrbOtGm8DnVhrNUOZPp5HWYnqc/CSiEWMSF4UQtXpoQQ6STHX3guqpEwCiEfYEIgo=
X-Received: by 2002:a17:90b:4cce:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-30a7c0dd06amr2414608a91.33.1746491148466; Mon, 05 May 2025
 17:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
 <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
 <0a765d57-0c9a-4732-b560-203f03f903e9@linaro.org>
In-Reply-To: <0a765d57-0c9a-4732-b560-203f03f903e9@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 5 May 2025 18:25:36 -0600
X-Gm-Features: ATxdqUE0KEG4092IatmhE_rOB2p0ZrPYjF4CU64ISAXMFcMf1GYUChaiRd0uPzs
Message-ID: <CANCZdfpg6JEbDx3dJvCcdQNexcjW+zBYzjhrmtDDLJC8rm7meQ@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I'm also ignorant of plugins, but (a) if not enabling plugins is a nop
and (b) plugins either work or fail completely, then I think we can
enable them. If they cause problems when not enabled by the user,
though, we'll likely have to revert.

I don't know enough about them, though, to review.

Warner

On Mon, May 5, 2025 at 12:38=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 4/28/25 3:57 PM, Kyle Evans wrote:
> > On 4/28/25 14:36, Pierrick Bouvier wrote:
> >> On 3/31/25 4:42 PM, Pierrick Bouvier wrote:
> >>> Nothing prevent plugins to be enabled on this platform for user
> >>> binaries, only the option in the driver is missing.
> >>>
> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>> ---
> >>>    bsd-user/main.c | 12 ++++++++++++
> >>>    1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/bsd-user/main.c b/bsd-user/main.c
> >>> index fdb160bed0f..329bd1acc02 100644
> >>> --- a/bsd-user/main.c
> >>> +++ b/bsd-user/main.c
> >>> @@ -175,6 +175,9 @@ static void usage(void)
> >>>               "-strace           log system calls\n"
> >>>               "-trace            [[enable=3D]<pattern>][,events=3D<fi=
le>]
> >>> [,file=3D<file>]\n"
> >>>               "                  specify tracing options\n"
> >>> +#ifdef CONFIG_PLUGIN
> >>> +           "-plugin           [file=3D]<file>[,<argname>=3D<argvalue=
>]\n"
> >>> +#endif
> >>>               "\n"
> >>>               "Environment variables:\n"
> >>>               "QEMU_STRACE       Print system calls and arguments
> >>> similar to the\n"
> >>> @@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
> >>>        };
> >>>    }
> >>> +static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> >>> +
> >>>    void gemu_log(const char *fmt, ...)
> >>>    {
> >>>        va_list ap;
> >>> @@ -307,6 +312,7 @@ int main(int argc, char **argv)
> >>>        cpu_model =3D NULL;
> >>>        qemu_add_opts(&qemu_trace_opts);
> >>> +    qemu_plugin_add_opts();
> >>>        optind =3D 1;
> >>>        for (;;) {
> >>> @@ -399,6 +405,11 @@ int main(int argc, char **argv)
> >>>                do_strace =3D 1;
> >>>            } else if (!strcmp(r, "trace")) {
> >>>                trace_opt_parse(optarg);
> >>> +#ifdef CONFIG_PLUGIN
> >>> +        } else if (!strcmp(r, "plugin")) {
> >>> +            r =3D argv[optind++];
> >>> +            qemu_plugin_opt_parse(r, &plugins);
> >>> +#endif
> >>>            } else if (!strcmp(r, "0")) {
> >>>                argv0 =3D argv[optind++];
> >>>            } else {
> >>> @@ -433,6 +444,7 @@ int main(int argc, char **argv)
> >>>            exit(1);
> >>>        }
> >>>        trace_init_file();
> >>> +    qemu_plugin_load_list(&plugins, &error_fatal);
> >>>        /* Zero out regs */
> >>>        memset(regs, 0, sizeof(struct target_pt_regs));
> >>
> >> Gentle ping on this series.
> >> As we didn't have any feedback from BSD side, could we consider to
> >> enable this upstream?
> >>
> >
> > Sorry- I have no strong opinion on plugins, but the diff looks
> > incredibly reasonable and non-invasive.  I'm not really seeing any
> > reason we'd object, but I don't personally feel qualified to review thi=
s
> > (except as a basic human C linter- I can't imagine the added calls
> > breaking anything we rely on).
> >
>
> @Alex, would you be open to enable this, as it concerns plugins?
>
> > Thanks,
> >
> > Kyle Evans
>

