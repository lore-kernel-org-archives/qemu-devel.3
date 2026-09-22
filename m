Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D946C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 03:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8r0q-0004u8-AC; Mon, 21 Sep 2026 23:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x8r0m-0004u0-4w
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 23:17:40 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x8r0k-0004AW-3V
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 23:17:39 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa22408406so5597086a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 20:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790047055; cv=none;
 d=google.com; s=arc-20260327;
 b=bo5frz89jrBmF+VlNclIAHJCOCmbc4P136Z67m4rRrpZBFOsjeLEUnZKLLPJ0XDLzk
 3uiuZL5cyWr2HN5SshHTXVvzU6frOoHbbeXNeI/DcEjacLPPAThFuNZx43o9cPjyvq0H
 pJmfixRXZcxKItIm3UqMtFrSh/xWxzeib9AimagMurRpcshgOgg5r/IebOxFoegRR4eT
 Iva3ruo9rTserXU5Io7ImfXNLgyOcgHBppqnPG4h4cfh00nCnS8WUiaeACgigOJy9Cmy
 pwNsNoYF1AZ57K3v6SjvZahNTDFsIuO6+QfndV6aJLkr4zwU0jUJvDQtYdCiQiOsUox3
 ZcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PqidSGbYfULF2f0+23lF1D4k6r5s90tgz70/QD5cl48=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=WJpkSwdgET2xthxNDu9noFga6mh1lHDZFQEYy+puoQR5+VGV/d7AAW1aCT0Qd10wVO
 ef2btSld6OlpnbtqE+aaR66lJ7pNo29CDK6T02sbsldpXSUZJzgGT01Dfglr9dw8SEMs
 /T57+/4/sovTF8P8Suz2MJZrJSmzWnT9q1/EYnOHtYR1aPByy9FW9vM4jsiaqgcacFRZ
 kY81ea25ENsVFj8gJyNH36uhcBqQC0aXU9C4ABkKnV6CNCyvbnBBEXmdTweeaLvWjhjR
 vD84oMiGFl6kYCpBn/wUsCnzp6UhqRCe8pMsZAC0KWAHEG1spahjD7QmRVYx5019B+Qa
 9V8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790047055; x=1790651855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PqidSGbYfULF2f0+23lF1D4k6r5s90tgz70/QD5cl48=;
 b=GIc3ZWUXs2ITRNX7rWz7RfVXMKUXwrra8PHz9YWBkZZzMITq/zKfXE6KaozwYUri+N
 PlsC5mhzEazwQ55j84ky56Q55IXwxR3Oe5TTI30rVJU8KGBGJra8p+aMiMGS6ebRCLjM
 cXd60UZN3As4lSaN5PkM9Iup8lauoTBdj+EAQACwYFsqBjVvMx+0kz3algxBqzvLn/wH
 JBcShy1NHjyLGeC8dVlvAGTC8yoZRnMhQ4e57RFvJsurjjinwdUWYJzSr+fwcOx0AjFD
 dX5sYnePZZsK3Zk6hzedjnZckTY6OwyH2jd5z0slPACzTLteJa28tk3cUHu8bmVJ+L2R
 60Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790047055; x=1790651855;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqidSGbYfULF2f0+23lF1D4k6r5s90tgz70/QD5cl48=;
 b=OQqVrmh3opsjpilWhu+J9CgZeMjC27UggdquvCd0HFIsUv56ppXPQ67kJ9nSR05kMR
 +PgBVDylZH0kMcWIJXasVTlI0pr6VsOyrX+osPYHZF/O9Cbh9yKJNXM0140uhclqMrRC
 R8OBjRwYkvPHNcrctg8PYjFd3yWtafqtUHQ3Xewzm50o48OXPy6At/mub8orMpEzTI4n
 cToY4I7y6RsNLScottbG+S4XzX3dnyzxfXdh/1lr9mM9Y6CmUHSnF1DB9C9cDqg6QjCb
 j6G8lSoYPyDU0HY0YrOnPUmSYgMxbWYbombC7vgGw6Dri32Ct9/N54AS+tOoWKFdRffv
 w5MA==
X-Gm-Message-State: AFuF++mWr07fWwF+9jTPPWeDlhnDTh1ZqrCVtXt7q2moBoBrGzw8Wvyg
 NMNWlhwOrvgWNLQQSpJP+d2HUgjgQHyckdibgLsNTezxg78HAIWPFJSSzmAt0kP01HzoIGbDNIm
 f6N1BIys05Yb5inRLjJVceOurmdK2owE=
X-Gm-Gg: AYBFou3YRqWkpvsL7rcbTqDGwAwkeICg46vKK9urZ5dro9YLNcu/n3XT89mtodMZr2U
 KrgtQO+LCl8F5kHQ98omxxhklp4L8rD5WUwjb6kVP4PWrS5DiNxMXHgvh/Cpm0yuiSzyyMy23YH
 SRViQx5PaRtbgaY3nXtXItDtu5skPsa/gWs4Mg3jokHB3Vpam7K2qUf8NEhYJiPeAfx0BvddbxE
 tskwsEYTRMqSwPgzlM1pcryB4IiyqUHEVsQ+oR/hSqP6HOKT5Pjy2L+T7rCCL0XpyZx/APTbZKu
 kzZufwdDg9hGMCVZ807xCg4iH0F1ul5PTILIRIPR0k7iplFH4RbInJlw
X-Received: by 2002:a05:6402:3785:b0:6a7:ee56:814d with SMTP id
 4fb4d7f45d1cf-6aa5798162fmr10875059a12.27.1790047055321; Mon, 21 Sep 2026
 20:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-8-zhangckid@gmail.com>
 <20260916194725.GD162769@fedora>
In-Reply-To: <20260916194725.GD162769@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 22 Sep 2026 11:16:58 +0800
X-Gm-Features: AcwNN1UgHQniBMSd_fmFh5js32hVdlyL8o2CuffZmSkWuZPqswSiHme6uczOf-Y
Message-ID: <CAK3tnv+OCV5c=+13bVbg8XxTGf5EWTOJcXTry9+QVvWZF_4R+w@mail.gmail.com>
Subject: Re: [PATCH V17 07/13] net/colo: track IOThread references using
 path-based holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 21, 2026 at 9:37=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Sep 15, 2026 at 06:16:49PM +0800, Zhang Chen wrote:
> > @@ -1404,6 +1410,7 @@ static void colo_compare_finalize(Object *obj)
> >  {
> >      CompareState *s =3D COLO_COMPARE(obj);
> >      CompareState *tmp;
> > +    g_autofree char *path =3D object_get_canonical_path(OBJECT(s));
>
> Did you test this? I think object_get_canonical_path() doesn't work here
> because the object's ->parent link is already NULL:
>
>   static void object_finalize_child_property(Object *obj, const char *nam=
e,
>                                              void *opaque)
>   {
>       Object *child =3D opaque;
>
>       if (child->class->unparent) {
>           (child->class->unparent)(child);
>       }
>       child->parent =3D NULL;
>       ^^^^^^^^^^^^^^^^^^^^^
>       object_unref(child);
>       ^^   we are here  ^^
>   }
>

Thanks for catching this. You're right =E2=80=94 the canonical path is no l=
onger
available in finalize().

The local fix saves the path(like the monitor parts we discussed) when
registering
the holder and reuses it in finalize(). I've verified object-del, quit, and
initialization-failure cleanup with the fix. Will update it in the next ver=
sion.

Thanks
Chen

> Stefan

