Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC965C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdN2o-0002VP-4G; Thu, 22 Feb 2024 23:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN2m-0002Ue-DZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:20:16 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN2k-0006hk-5w
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:20:16 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso317800566b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708662011; x=1709266811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blLoU+6k7MIlhBo6C/f6eewEZV3lVGSTs1jtLWtANGg=;
 b=GkX1XQ2TnbtOVn71/iT/PmMWA9QBMei8MKUcMQOk/fONdXOzr2zKbKszPZkv1WHbey
 ZS26+VRMKpy7o7J+dbc8O1rcDBrFoYqgvWYQp+o7aUPT/Fm7wpTcslHrb/1/17jWViRi
 mz4OVb6uUdILiANVTyDlx+TIExGmB7cQydNuEDWF5oN5yDL8jfVAU4HzPu6pO+/qBVSv
 4D9H1MQxES6xffRqUDyo6sVQO31B/bxeX9D1EAMhgU2OexgwU8gSd1/WWgq8NbRF2mm6
 oMbgj9oX6puAJCZEtsQGw1L0bIMvRSZNJoK0O7ui/cJXsB08z17FMUZHQFGlt4GY/msf
 jN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708662011; x=1709266811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blLoU+6k7MIlhBo6C/f6eewEZV3lVGSTs1jtLWtANGg=;
 b=WKdvht2BZX9kWHJrRuatCXvmJNUywERVGyvc9PQ1sJu8oEKz3ccaEwczJNKx85C36c
 7ePaT07FQvyAXF5WHIkmREgEu5TKZNPFO7ZMbamDEBW9+k6hpQ5ZgPb37cn0XA8o0PyE
 2h9+mnSR+zJQUef3EiNS2HtL+pAv5aXPGJCFbSY7/tFHo3Tgsz/6fpH6SmNWeyjmvUKj
 aA+RyP1FbGOhObqFwOZT300JicfaK8OH9Nt/0/g8LKVK7gDqAnAAhzYLoedO+A7BdBEX
 Q0rKF75dCuzQuopCPA4359SnDqE4Sw1foqLcc3Sd9pJU5IwB17t9JiDTusl/OaKQxgAI
 xGBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXohmJt+z1/EFMkuPg9xRtCsbqZFMPSyo6ik2NpsfJwHl/WlrLY4u8hV7RZ6W/awcWnX6aa4aBtrpVSIXyAFlZ8L6PDkng=
X-Gm-Message-State: AOJu0Ywb1G91R74RcGxlu9ouBzoo0XrI0QSUuc3C9rU7bzdvMWdXjBpj
 WwLpx+cMpUonS+j7BRFXX/IpuVJoI/oTdkJKY0WObhqiVPjiQ9lGGe17HvQcfaS0QBBiBWkvHww
 AVkEIas+7tOOO7X4iRjl3EFXZppzs7DKBKqv7PA==
X-Google-Smtp-Source: AGHT+IGVj+rfylx8fgCJy4/1gXFia1/mi0o7J9AF+K8X21aJKcCKtyN4JEce4mJ6ZndGvRVhJFbaVdqipWhB+PonaoU=
X-Received: by 2002:a17:907:b9c5:b0:a3f:cd6b:80fd with SMTP id
 xa5-20020a170907b9c500b00a3fcd6b80fdmr290746ejc.7.1708662011195; Thu, 22 Feb
 2024 20:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-6-hao.xiang@bytedance.com> <878r3dbkkq.fsf@suse.de>
In-Reply-To: <878r3dbkkq.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:20:00 -0800
Message-ID: <CAAYibXg1Q0DvsoOA65dp8uguL8xf7kxr5R7xUEMG8_wc_asERg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 5/7] migration/multifd: Add new
 migration test cases for legacy zero page checking.
To: Fabiano Rosas <farosas@suse.de>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 21, 2024 at 12:59=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wr=
ote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Now that zero page checking is done on the multifd sender threads by
> > default, we still provide an option for backward compatibility. This
> > change adds a qtest migration test case to set the zero-page-detection
> > option to "legacy" and run multifd migration with zero page checking on=
 the
> > migration main thread.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index 8a5bb1752e..c27083110a 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -2621,6 +2621,24 @@ test_migrate_precopy_tcp_multifd_start(QTestStat=
e *from,
> >      return test_migrate_precopy_tcp_multifd_start_common(from, to, "no=
ne");
> >  }
> >
> > +static void *
> > +test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *fr=
om,
> > +                                                        QTestState *to=
)
> > +{
> > +    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> > +    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
> > +    return NULL;
> > +}
> > +
> > +static void *
> > +test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from=
,
> > +                                                      QTestState *to)
> > +{
> > +    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> > +    migrate_set_parameter_str(from, "zero-page-detection", "none");
> > +    return NULL;
> > +}
> > +
> >  static void *
> >  test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
> >                                              QTestState *to)
> > @@ -2652,6 +2670,36 @@ static void test_multifd_tcp_none(void)
> >      test_precopy_common(&args);
> >  }
> >
> > +static void test_multifd_tcp_zero_page_legacy(void)
> > +{
> > +    MigrateCommon args =3D {
> > +        .listen_uri =3D "defer",
> > +        .start_hook =3D test_migrate_precopy_tcp_multifd_start_zero_pa=
ge_legacy,
> > +        /*
> > +         * Multifd is more complicated than most of the features, it
> > +         * directly takes guest page buffers when sending, make sure
> > +         * everything will work alright even if guest page is changing=
.
> > +         */
> > +        .live =3D true,
> > +    };
> > +    test_precopy_common(&args);
> > +}
> > +
> > +static void test_multifd_tcp_no_zero_page(void)
> > +{
> > +    MigrateCommon args =3D {
> > +        .listen_uri =3D "defer",
> > +        .start_hook =3D test_migration_precopy_tcp_multifd_start_no_ze=
ro_page,
> > +        /*
> > +         * Multifd is more complicated than most of the features, it
> > +         * directly takes guest page buffers when sending, make sure
> > +         * everything will work alright even if guest page is changing=
.
> > +         */
> > +        .live =3D true,
> > +    };
> > +    test_precopy_common(&args);
> > +}
> > +
> >  static void test_multifd_tcp_zlib(void)
> >  {
> >      MigrateCommon args =3D {
> > @@ -3550,6 +3598,10 @@ int main(int argc, char **argv)
> >      }
> >      migration_test_add("/migration/multifd/tcp/plain/none",
> >                         test_multifd_tcp_none);
> > +    migration_test_add("/migration/multifd/tcp/plain/zero_page_legacy"=
,
> > +                       test_multifd_tcp_zero_page_legacy);
> > +    migration_test_add("/migration/multifd/tcp/plain/no_zero_page",
> > +                       test_multifd_tcp_no_zero_page);
>
> Here it's better to separate the main feature from the states. That way
> we can run only the zero-page tests with:
>
>  migration-test -r /x86_64/migration/multifd/tcp/plain/zero-page
>
> Like so: (also dashes instead of underscores)
> /zero-page/legacy
> /zero-page/none
>

Sounds good.

> >      migration_test_add("/migration/multifd/tcp/plain/cancel",
> >                         test_multifd_tcp_cancel);
> >      migration_test_add("/migration/multifd/tcp/plain/zlib",

