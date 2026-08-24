Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4779AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOyk-0008TR-Ix; Mon, 24 Aug 2026 03:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyOyj-0008TA-6X
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:20:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyOyh-0000Ui-Bb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:20:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2932105a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787556018; cv=none;
 d=google.com; s=arc-20260327;
 b=GZz9aLgo/ZI73lVh+k5hOtyGl3CkWz+9V6FQlvp51pAIFakP3lo/YjBkhe1itVni73
 pzaTIOn/qoiazkalQYrrxHOUawQAFKpZ5e5B2ymV62hOTs2s6qyWM05Nf2YTdh4yt6nE
 7AXxZjkB8pXX9YK7tZBtSEmaIQibjuAjr+4ZzeElIqqOCOhO0G11YdZUVHwL295oWsAd
 sHToesVntZz7p09cj7Ker8uPRDhGcBkYmp8NPBIP0VwqGbwsNfYM6FkVQDck36SuzxMu
 otDUAkgPZ8oNpDZStgsOPRvXJ/sKHw8Fe8c6jLzKFpH8hmmpOdvcAlP1kArTB6wesmgp
 oI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=75xUqyRKHGuQbI2RoUE9b4Vgd/cT543qUvORiCSg6bo=;
 fh=kgT19oiRK75ZQwo35VLqw0IgPa25di9Lcd0+tomWJi0=;
 b=nrmky7zauCASLfyEB4cgqiRExPlkms/yK4/FzMK62koGKUHTC/An5injc1FVYu1Rks
 lg41wCLsAfHYn7zSp3sDAFao1zfLsXgS7E7W+8NYFgU+A3DbL+p7K8G6K1c5YZJHhyzx
 oJBLUUcUOHMqmUTKa9VBAEbAHbowcsNOX84msF9VV+vaLC0GoxGcxfE67vbZ26QaXJBn
 dnMhX58yh1+tAaUMZMHLFBJDeXkCrTo+rs+blGxeNku6+H8oB6uvMBB56rtfYN4sKTGL
 F5hquaQ04ji79UEq2CrqElntgYy0Wn6+vUi8i4djJ9O+FAE03DW4RbGlURm0VajEaFRr
 5fbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787556018; x=1788160818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=75xUqyRKHGuQbI2RoUE9b4Vgd/cT543qUvORiCSg6bo=;
 b=UF8Xk+YKcWuHNU3KOTgTBfjOGDD+K6J+UQ6L9mNON/2vl+iXZglNDHb1TXVhXpfCEj
 MCa66nKVZ0mYHn29goC16FHPP7L1u9Ti0eqIO7mHL78I8TIMMC22gbbSa68D7YJ24kiD
 F33x3pbAWZCezm5L1YEOG0gjqfye96a4zUwvpNHxvmcSi6ZenQJ0wRde2zOdqkB5DbOw
 QsylrdvE/a8/CikM+2HXpiOkPwiIPP9yJghJvpL6YIBGySIQPGOLb3zHWYQSWiJJ+Q8j
 17e14rkrYGY1nRa8jxy2Rh2I8w43wkN2CMRS3yvnz+QGkfzOX+uJ6KLIf0pB1ze+5HCf
 /v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787556018; x=1788160818;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=75xUqyRKHGuQbI2RoUE9b4Vgd/cT543qUvORiCSg6bo=;
 b=YJ14ZI1RkBEKHTmqGVH8Rh4a7ibydyXLe5SsuwpNXLJ0IYgHsiYGL5/DeQn96JAHwK
 8EixcrIV4w822r3nWRQ6sQpBwUoQxREupNlquOS2r/Hv9xluhw2k56cmYdz7cD/eW3LI
 fkGz0oE8aaBylViVxHqXrEbltYTSjjYzu7llpdC4aD8mnb4N/YSN5jYrH4j9pupQ8Ar5
 FGCuf5/cFU/ZTCyANuDYouEmlGoASxphcGWnnsvWTXJ7FhZKMgHlgtMc70y83aWdsgNW
 wmvaoI72JCDF05bDazpOq/MGMOkOKVQZNLnw4fq0c+TNjHcJdWyHxfkd3p2ZUHfXgfHt
 jt4A==
X-Gm-Message-State: AFuF++kks5vHQ5VIl2LTvdOdwbCaRPDFvMmo69CP11Eds4nKBwQlMOG8
 rEbSpsmMXOE0jqCo8wa8Oz7oJcJ/cwOQgk95ibHYzScmWa1JLPtM2JFJC0HZ506OeKjq+GMaKhD
 0lBSvR7U3lnBkWHArxnzJbJKQIcV+0k8=
X-Gm-Gg: AR+sD10i3ULEVF/0OYS+imwCJSgnuzFNJv+VgleXrXk6dYUp4HniubQSBIN3UU0aCuY
 TNuuzL82nDbQqVY/fm0oU0FX39ws8XHGRBPvzzun6iK4iIFFLIUbsqN/AxNLP574IDtcw2/sOep
 Po3qdXUgZMV4aC/LcJrJfi3GKALPbYlpU2Hi3re+H7PUhoKmEqNIvmPFtGAaWs9kQl1b39MTjoO
 0c7eSYaN/9QI9Y3uJK6KYfXtge82chQ6rWFWhZ3mzS2cBy8fzE9msbQ6sFXGaAmRgjsp+OTl4Y7
 pdqeKRK6crPsyca6MNaXHHwKNTfsLKW5Sq/4xmYiXgBeKhpo/OwXoKtZhHIsejBljoMqFd+WX7S
 W3x8ZqxHbH9I=
X-Received: by 2002:a17:90b:5706:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-395deea4a72mr31464430a91.5.1787556017744; Mon, 24 Aug 2026
 00:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-subprojects-ignore-v1-1-0640f7fee388@codewreck.org>
In-Reply-To: <20260821-subprojects-ignore-v1-1-0640f7fee388@codewreck.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2026 11:20:03 +0400
X-Gm-Features: AcwNN1VL2Zz565nBr9gy_TG52F3q1wxjMQJfJZE9h7_GaegbNKBaW8oJfwCB2Ms
Message-ID: <CAJ+F1CJe4x1Pne=57rUQ=HMdtzygLiWPOOsSMPXopNYDXWaO5Q@mail.gmail.com>
Subject: Re: [PATCH] subprojects: re-include *.wrap files
To: Dominique Martinet <asmadeus@codewreck.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1035.google.com
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

On Fri, Aug 21, 2026 at 10:48=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> The existing wrap files e.g. anyhow-1-rs.wrap are ignored because
> meson extract the sources in the subprojects directory
>
> This is not a problem for git itself, because files that had already
> been added are properly tracked, but tools such as fd-find blindly
> trust the ignore rules and fail to pick up the .wrap files, making
> discoverying the build system (when e.g. adding another crate or just
> curiosity) more difficult than necessary
>
> This added rule re-adds the wrap files so they now properly get picked
> up.
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> Stumbled upon this when looking at the rust build system out of
> curiosity (because stsquad asked something related on IRC)
>
> It probably doesn't matter much, but took me more time than it should
> have to find the wrap files, so might as well improve this for the next
> one to look at these.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  subprojects/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> index 011ce4dc3b77..4bdedb081601 100644
> --- a/subprojects/.gitignore
> +++ b/subprojects/.gitignore
> @@ -26,3 +26,6 @@
>
>  # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues=
/14948
>  /.wraplock
> +
> +# re-include wrap files regardless of ignores above
> +!/*.wrap
>
> ---
> base-commit: acc271509ab015b9e064065f26d41a61e01e641b
> change-id: 20260821-subprojects-ignore-8a9460a6d7ad
>
> Best regards,
> --
> Dominique Martinet | Asmadeus
>
>


--=20
Marc-Andr=C3=A9 Lureau

