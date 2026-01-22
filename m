Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224F1C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vir8T-0000OK-Pg; Thu, 22 Jan 2026 04:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vir8S-0000Nz-BX
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:37:52 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vir8Q-0005DY-TE
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:37:52 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-794279c3b00so7665697b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769074670; cv=none;
 d=google.com; s=arc-20240605;
 b=cdP9edNDgcdM4SC8WbrGbKHX3i5hy+hXqAiS/QucoL4v0YwTB3AYvLIYnyNXJv2pvT
 L2hOHqm0ts+GC4JfbY4rlmqNFwhQoHJpKZqyVqvdsG4Z93gWWf39DNOP+x79zbKtjD6J
 LYQNp2vWtCNFtnsKBfzn2VSez94m67undjtzvjXTmo9OhwwqOSZ7x1fblmWrMgVYGn8z
 88dndkNItenFnpqY3VhQUsELt0qyxa81dn7G9BEMRm+pHUHImOMolWAmR+fCn9ij88QA
 ou+A65I9L+VyMxCW1UPW7q6o5s7JDdXsr/ncSFB3AUI8t5VcRF1qOmW0Rdv+cN/Q+BDe
 4ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0D1DR/Md0HCnsjLVs/nolihT4oEEbYWZcbxqhhuPxkM=;
 fh=a1Mn/BRnc7FV0jPHhWX7Hi8o0Z7BvfXMJ6Stl/SFv7g=;
 b=IDucLTrs7X93wPPy71zm+rlFtk41NqHGhDgdkqrE9mry+jgqkOYS2VXWH2hZphfiqV
 E7+ay0rVdGs7b8PnM2KGORWdG8GnP+Zxh8M3mk3+cYptc5Cuz6wecNOkOXdWPsflU1CM
 CAMcITwRr4++R45rd1CiNr99CSLzC6ewB7nqD50GgNvmAzJs6VpCxP3Oh94d+39p7WS3
 hhoAfU1B7adYJIqrM6vgW+6F9V5fEHuZiCxj5709WYWNb7xUpyiEkF8R8Q4O7ksk0SmR
 aSwkdAHUQ5MR1GC7KpCYZ2I+v1uh9aB3NJNQdThyfGryzhC44GoGQxOVeiixJFkadZvb
 BqUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769074670; x=1769679470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D1DR/Md0HCnsjLVs/nolihT4oEEbYWZcbxqhhuPxkM=;
 b=q4BCH5sB1ebilXL3k8raJ1KublVd6Xm2uq/IkfjDoumHTHtjnpwkuTwhLez7DqQWiY
 NmSIb80CQfmR5PMtDIGYLa6xWPLT43DGRRzQzGTu30ECloOD7CAER/fpdnSNOKU/4Ojn
 JO6NizEyw5UF7VthDk51s5v4DnNkoc07X7qbKPK/nGyu+NaAMXUmJfXRG856bGzHsPS8
 0ZECXsKMNAjGHo7onZZT4sEKZimtDD5Gx9xDV/i1nSDHAepgcf/fS3MLK0Xhq4o8DAJB
 Lyr9VdEwq+l83GED4N57w1dFSP9oS5EuR3CF3RNitEmWCdvJdVxTdCfnlAba3NiS9TmC
 g79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769074670; x=1769679470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0D1DR/Md0HCnsjLVs/nolihT4oEEbYWZcbxqhhuPxkM=;
 b=MC88lbPu8mtD576IcAvE0Kgrh9+xiwjfILv6Iv2r5AJXVKqflMpeljVwbn0M9lv6Lt
 3Lx3UyQB8IgWEQfekU+4UoRtFgj1y1/X1lYsotGbEG+A71IVT2R1IYSAmFyElQSV3HB3
 IVOlRnKdSwkezziRrwLx79iw8/5o1UhO6nH0yKRkFa4li7c6Sm9R8uUA6zxKVtsU0XS3
 GDJi0bqgjhOUIYJ0z5/+Y2T04+Y0IBN34yi2vc7r7Z3B2eYLiztMQgYY5NcNagSDQpPj
 w+cvkTJzZTQyYCH4wdTgbii5B7AdrXkQ7Kw/CDJXj3U8dLMKEecqaU6lNfxq7BAziWfX
 6VqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5iVoIeMwLy8QC34ad3+7R4/D6iD2NLXunIkc5E7gHxije//C2vow71SSdZE4OUVxrKpnXILTxvmrn@nongnu.org
X-Gm-Message-State: AOJu0YwUm2bpRI3flyyA6ocTimmHZVJDqCCu4nGnpnfozHjQZHsOlOme
 moq+DGQ+WRtKmlaLLHT55l9nzE3hIf1SLzk1rI61CSs8qb1jG4a2BW/TgbAfkdLUopUOgvEE39m
 m+D0s9auO3TNvSmKWZrcZIfPBn14RmnJnGg3WN3llvw==
X-Gm-Gg: AZuq6aJD0keV822kBiVJq0lQBVVlI3BnTM1VsugdbDAGiYKNyUrWzt0BpTI8N6fynlP
 PyCKGwkQUpOs8jPoPPgsd2CgWOMg6VD54EOVwiM7F9HNEU3ct+zSHigmZhvERnY+T6SGXAKDZlk
 8rD3i2DtYJ4xmWd+Oc3QEhfBOyM1VG+w8Cz7w66A3HQz6A6vrQRbPZrevun7cxKgigV2ihQMu7x
 NlxUMxDLrMd0Z+wfJwvF1YMQbbSlI8nMkIHL6ZF10Wz0VZZnR5S58NZiFlPtQYNhsUMCmxXhhmI
 blha
X-Received: by 2002:a05:690c:909:b0:78f:b163:74b with SMTP id
 00721157ae682-793c53c5a71mr171746267b3.59.1769074669665; Thu, 22 Jan 2026
 01:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20260122090352.9901-1-thuth@redhat.com>
 <aXHtxBfuIRsJ3P_M@redhat.com>
In-Reply-To: <aXHtxBfuIRsJ3P_M@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 09:37:37 +0000
X-Gm-Features: AZwV_QgMVUCGuGW9Eb5Q7AUL7sFLQt9sGdF6GvYEulqMfc2abXHYliplFfhKLs8
Message-ID: <CAFEAcA8QNKwmOndVbq3eTkihpKjD0t01mAJ7DJLOQA3JqkkmWw@mail.gmail.com>
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 22 Jan 2026 at 09:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > We stopped supported 32-bit Windows hosts a while ago already, so
> > let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> > that this switch is not about 32-bit Windows anymore.
> >
> > The patch has been created with a simple sed statement:
> >
> >  sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>

> > @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b=
_coverage'))
> >  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> >  config_host_data.set('CONFIG_LINUX', host_os =3D=3D 'linux')
> >  config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
> > -config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
> > +config_host_data.set('CONFIG_WIN64', host_os =3D=3D 'windows')
>
> While relevant to qapi file conditions, from a C code pov all of these
> are redundant as the compiler has all these facts built-in
>
>   #ifdef CONFIG_LINUX =3D>    #ifdef __linux__
>   #ifdef CONFIG_POSIX =3D>    #if !defined(_WIN32)
>   #ifdef CONFIG_WIN32 =3D>    #ifdef _WIN32

checkpatch will warn about use of __linux__, though, so
hopefully we don't get more of them in new code:

WARNING: architecture specific defines should be avoided
#4761: FILE: block/file-posix.c:4761:
+#ifdef __linux__

It fails to catch _WIN32 because it's looking for "__".

thanks
-- PMM

