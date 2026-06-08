Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7428CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWKP-0003mc-Hb; Mon, 08 Jun 2026 05:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWKO-0003mQ-EH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:31:28 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWKG-0002Ee-RJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:31:22 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6605c3453f2so3934024d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780911079; cv=none;
 d=google.com; s=arc-20240605;
 b=GbEDCXpqrjQin/M3COxmvl+CTAYtxq2GtxsTHfBN/hgycijhg3MtG3Gz1aBu0mDZqJ
 orRgITS7Y/Kv0lwKpbp7qyGPQYwVJW9zxc+qQLPpMehm0aCAOxPKTTt10Pz+KdKahisV
 UcdpNMsY3cMsUZBPRrNt2/jw8OjWjD+X8tNM+aBIGvTG8s6SbbfaKbJLSjstOPb3cEa6
 ocaeaU53bW8kjC21AN8814ynS7SWW7UWfz67adlkk1hRaUhA06rthZGfQdMwBIh8ls20
 EbvlZ+cuAs8fjqzWjGfXsbJW/oZ8xg20iDlpdLwsdqwzup9ADOX7PEAySykakILvGqji
 SNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oN9vwWZquI/3ZWu2yPWpiXfFjfHxa2fsFxu7s44lRSk=;
 fh=9EeywghUUErPHelOOUazhOgI6Eicsx7RNvMDuf0Gp+8=;
 b=k8VWIz8Bhg0gYaZiIbJ96tGsRQ6u5A9BsZTjwpi11Q/IAGzA0MoNXXakCX1IxD9LfP
 COUDVsEbDw0BIX4QgbS6kZTdQPsqhfifJUrZGYLeN07navT57yy44x9vmoJ9UpV7q61v
 /kdSkO1jkAikcr8wkXuWh/NMw8pQ5TC+Il97CUMsrJ6yWZLISi++9p4kvqHA8xxSjEYq
 fm3sSlYzwQlFnh1OdwFRdT/Zp08GL5DcpR6/epoFjF2KN3wUKc+WQDwubJo3NKrp/Ple
 iXEdwVzIVMVlXQpD1R/+j2+dK5V9AB9xMYHP6y31+abY5rtUBXRJahOUs5RUylsfy83u
 ODvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780911079; x=1781515879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oN9vwWZquI/3ZWu2yPWpiXfFjfHxa2fsFxu7s44lRSk=;
 b=ZKJbHb3vdtg19oyBIl+h/MAaFj5iMAKPkBktoyvS7QmOI6ceJwqniQynIXYSxz1yZZ
 mPxq3bdG8xos67AxCNl3pZvaw4haJaCU+Ni3fBYev3hl18khlg19a9CFsuGkGWB5Wleo
 YqJAmkmamTuqBe1GiH8kO+VMyPGFl+cTZHTY1/4vP/Qhl0yJgzqFnxetLchUBWZYbyDQ
 cD2voAZOXzKugB+0MQeh7vNuCiqfrXLtmsU2tcLLt4X/LihlNzEVV0Cy+ByyFvpksuj7
 iRmxEGx3H1GgfTligiP5IIrBhFz1Y/+QY+0EmbzgXMBWFmuYLOGlHTwIz6mw/h6N5L5G
 7JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911079; x=1781515879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oN9vwWZquI/3ZWu2yPWpiXfFjfHxa2fsFxu7s44lRSk=;
 b=By9S4ZcahDcEksa2h/YwCLNnrKGKJgFUCq1VQG6MtHJtoUGVtsFdaBG2O+usQUeQSC
 22JxeVoFbubnT0b7XI7PTYXF7vel/WJUcmpN5YOeYq3PzOh+jpangPVXSbYuWvDQTsZm
 71aqw8QYKRQMuDfWJ6WOIKyT+/RYSzTjIIMO8BdmSREezuKqDRpSMY47ZqwF+/cSrcrl
 y7Xkw9xIPPBGscjue0b+eXQLN464Yg/BqDXtjFHOQhHTwM551ZaW4OfJrdLoXn/i6ltC
 Q54N2HGNqCip/XfEuEm1VFv3OHiUeHSLn6JFYlhqhBU5ou+gAEXsr+RIdum+ym7wD47L
 m3VA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7CQw3cFRcK22EnH9+iyd5NroFKlTP6bKwOFtijwZpByslh+MuszIzlRbm5ebbY5K8cZ/gTItd92Gk@nongnu.org
X-Gm-Message-State: AOJu0Yw9h6kKFmWgM8pHt7vw1dxhcHdmyRpTHBbmJwQFQaBgDuJOu0Wf
 czYV5I4WpExlZEtB+zKc6TkUmX+WOddkgiXbmxq5JWH9zzyb6rIiDhPeAQW4DlzhMG/gfn/7Mn0
 H7ocZ3F4ZjOq7rOpCxaCWFsLfVEoqM1FZxWkcu2ovFQ==
X-Gm-Gg: Acq92OEjcxyMBIOGZ4L0q1qtr8ekWZZo0h/wqNum/CkQsnqTaKbrNVQbdk0IYeXk2J5
 Uza/UBmKST+1qL3IOj4zQw06GwKZjdYxcv7WTQt4GobrMrNziaA+Jas6jd63KWqXhxEKBFo9tUx
 ylgnl5BwyMD8es9ZvQEAdvt70ma8T5Pm7cONGr301i2qNHpA+lUyQjleroFSY51PsDob6l+TDV9
 8YlMkw4gt7HBANzcZacp+BaRWtPczEOJGUVM8wc433kbo09e7vEztU1aEjhjzw4P3dNMAo+oX3A
 QrW2vUIlxmQdkQnCANDfwF2nPb7izkQjkMYHuJ1qMNJ6ctBCVNvgraRxQYjUe8IPiny3ADMtlcj
 tJw==
X-Received: by 2002:a05:690e:144b:b0:660:8e61:1a60 with SMTP id
 956f58d0204a3-661073da64dmr12014708d50.14.1780911079245; Mon, 08 Jun 2026
 02:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-checkpatch-v3-1-23fc7b12a7e4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260604-checkpatch-v3-1-23fc7b12a7e4@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:31:07 +0100
X-Gm-Features: AVVi8CdJ_2tpBNYedwGa1mA2eCjQAnfasGaR0MSbd8B3wTERPOAOwzEd-p_MoOU
Message-ID: <CAFEAcA8uV11z1BGp05gs+f-v4E+CE4DQQJa++DFUMxcCZ8kCDg@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: Check .m, .build, .hx, .in, .json, .txt
 and .plist
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 4 Jun 2026 at 11:11, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Check more text files: Objective-C, Meson, "hx", JSON, and property
> list.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

This is missing rationale. Currently checkpatch is set up
to check source code files, and the bulk of its checks are
for source code issues. Why do we want to make it also check
non-source-code files?

> -our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
> +our $SrcFile =
> +       qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|in|json|plist|txt)$};

If I run checkpatch on our .hx files, I get a lot of complaints
about trailing whitespace after "\" characters. I have a vague
memory that those are deliberate, though I forget the details.
We shouldn't add a file type to this list if it's going to
produce a lot of false positives.

thanks
-- PMM

