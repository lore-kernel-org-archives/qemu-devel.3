Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B137AFA0C40
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCuc2-00073u-C7; Wed, 15 Apr 2026 03:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wCubw-00073f-Ip
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 03:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wCubs-0001hn-M2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 03:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776237866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLTkSUtZGjJ3mw4Iw/f/5USpX9d2DdUlz6NxhSo4XEU=;
 b=cRwVzFJ8cZXfGjGEqawdHqBCBiOqKKISg3/LAy6Jv4iDpL8YZXlSkcax/leyBA/ZPHJJOi
 cVRcXvDWrrH3eRxVHxYHAMb/YsnYuhbxuhcTy7dQdhsFLei/5Nj8rrCCc9UE8DscoccU9y
 3swgqXf+JtU5FLKIGrj5I6YKe848D14=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-rHcZY0WANAO9NaLKjTon3w-1; Wed, 15 Apr 2026 03:24:24 -0400
X-MC-Unique: rHcZY0WANAO9NaLKjTon3w-1
X-Mimecast-MFC-AGG-ID: rHcZY0WANAO9NaLKjTon3w_1776237864
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so39858465ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 00:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776237863; cv=none;
 d=google.com; s=arc-20240605;
 b=hjfz3mF+0AI9HZnA5ImXKvF3Jp+0bXfE7Zzf81QLxYbURq03ew2cInjEqLDuWsgzdo
 jSr7V0ZIyHy+oNv0Y7zl5BEtXTwm/X5RRmUyu+E6shADEXAcrNclh287NDk9AH4m/wtm
 ueP8FnBaRlTECE54vPUSQ+lQ1Rrp6azNBhltrOGRQL9UOrJN3kcdv67vyfbqoO99r7WR
 8Nq+NrMtBnCVIG8KHtXOpP85A2v9jIVYhvDE30hRkEy4FnmguA3J7DjpzSg/m2Elkonx
 udY9y1DxUaYSitULf/Ul2V1HN+VNH9Ek40aSQGtKumNFSkUOjxAnKv3MQ6uU87ci8j+o
 oZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VLTkSUtZGjJ3mw4Iw/f/5USpX9d2DdUlz6NxhSo4XEU=;
 fh=J0lI+6V1e8A1yyN2nd5Guz99SJqLbGXMn75K4Y7Xiz8=;
 b=VdnK7XbkYB4Nj+fnSjNrLS163yQ16KqvZvmNS+DmP/R93lBiKsE0KMvESk4S3VZDlJ
 snCI9biyympEVveqNrMcmJIwpYuYcaRY1sqgpGLV54+1xNXUGh/LiMalizNXZ7i3jhzv
 0OxFkAceSAbwBs9P/uZRFZn8g1dVQ7sGqRfE+0i4Ntg23Ql3g6hBwWt0Eja9mXO3jqMc
 7cnMft8dqNCXgXW/Ed679N1VxIVBSgqpZaB7v5uBhSRx2JI1lY+YFAL5wf+hFHHqfTIG
 HpwdICL3waFUTbfY5Cv44pc0vS1ib6w7AwYMsoH1aDRJLPNbhUyEvjHfgxCCrW22MGNh
 5yFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776237863; x=1776842663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLTkSUtZGjJ3mw4Iw/f/5USpX9d2DdUlz6NxhSo4XEU=;
 b=nqMhwqVTAHkh4paxDuQFEtOWYiLblki68ddJK6rzmSYcmboJ830Mjqr25WfpK0xBlz
 1hbykC/nMgRFFjAWgJBUTPyzqq+k7OwxMwOxsZgDzX/qujKPhq7lwrTeVUr9yh0PID8H
 V/12iWBqj6t90eQ7qqE5z5tGpz6n8vMp2/Pl+6oy8pMtpIaG3kTwfwAjwJgFrOFLKO6b
 g1DfJd3E5HU1Wl98KUziBhsoRV47V00LuJfEiK2J+DhSpBk6E4uts3wuQH8wODOnBk0m
 iHwq/kiV2vSGvVAGqihxh5f5qJKNknVr6cOLQx7DzrFcD1vgOwdAOXFR4vEVoJy4JUfy
 zdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776237863; x=1776842663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLTkSUtZGjJ3mw4Iw/f/5USpX9d2DdUlz6NxhSo4XEU=;
 b=OJuvI98h2xZzuuGsrevQhvZ9nVrpeWM0/cg1+ZsAywwVG57074W4Sach+GXG0Rpgo+
 UWRXd9Jvx29JNAlTBqxvBoZwau1wtXcNwVKRu4PNcwo1LT+9Tc6RtfmhsrzNHNS/d9EY
 yam276qmrvUujGHqvW1wCl+mRYKLvLa3cL2Kgcnm5qtRj54oLGobC7yEAkvwqpyCgvAV
 xZbtYaonQMAYGaqNo8cailmPxpy39rH1gCpU1QpxgMjfCpWfrkV4G+Q+mI9E43WMzXaM
 0OaCl8n0HVx/02sjTqpNoJNRyzqph0EnQcovY85Fh0sS0jOmBQBoolpcr1N7lUrnRUOA
 MB2w==
X-Gm-Message-State: AOJu0Yy+wTy4B+dL9hpeZkshAN2zC08a+ysOfGOEZbuk0rCh2FSblvU2
 j8TLpSRnePYwTuncHjHAO75IqQ6GqpScLBNPlwmvf9Ofv1/C1wqY5QTy4PV+Ji7oZVkoeQThsyw
 lcubrGLaSub299wWaE0Sy7UVLmdtKzdC/nQhdrnQdA3twaK9PLE9u4UMuxXTTMLX4QutK7v5Rxp
 5VMGAaOL5tADPfgt1liYap0zjD4Y1iFEs=
X-Gm-Gg: AeBDieu6Xwg+cCrvkx+1BQJZZvI5K+f/BIDnjDWIe4mJldMPxPvW1h57ncc6ecAyuX6
 UDSYOzCBUMEmOCNNwQx59Q4LkmrdtS+oyH9EKEPHFBefgyhlJSqkdcq6rlB5qH5AUvbju6Gu9vq
 jx07h9r5k/gx8E1eOCJzrFFXaiHjtePPjgYS0CRmMPAPzZYsjFmvtK7rcdJ+MWZmenpXPC9fZ4H
 RvuHv8OR3OVvijA0o6KbLh30UFCrEDPTrTM0Ejs129Lc/lklu1O9QhLd7/fsP0/94pKsWnrBxqz
 wc5uoWPycSRPwdVI8YmQ7k+0uMbeUJwhwYI=
X-Received: by 2002:a17:902:c152:b0:2aa:e47d:e3b with SMTP id
 d9443c01a7336-2b2c711e5efmr159793685ad.0.1776237863478; 
 Wed, 15 Apr 2026 00:24:23 -0700 (PDT)
X-Received: by 2002:a17:902:c152:b0:2aa:e47d:e3b with SMTP id
 d9443c01a7336-2b2c711e5efmr159793515ad.0.1776237862865; Wed, 15 Apr 2026
 00:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260415012336.964736-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260415012336.964736-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Apr 2026 11:24:11 +0400
X-Gm-Features: AQROBzB1lF4e_yxJI5rM-veUZj9yBctZgnxAZteuLttqU2XWelLu5U2-u1WG8xU
Message-ID: <CAMxuvawhfAV5JuKacimbc6t7R8kz28bCaCmsQsyNv8CZ8JVvNQ@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc-clipboard: validate decompressed text length
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Apr 15, 2026 at 5:24=E2=80=AFAM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> The decompressed clipboard data starts with a 32-bit text length.
> Check that the advertised length fits in the payload after that
> header before passing it to qemu_clipboard_set_data().
>
> Otherwise a malformed VNC clipboard message can make QEMU read past
> the end of the decompressed buffer.
>
> Fixes: 0bf41cab93e5 ("ui/vnc: clipboard support")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc-clipboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> index 124b6fbd9c23..85851a632dba 100644
> --- a/ui/vnc-clipboard.c
> +++ b/ui/vnc-clipboard.c
> @@ -281,8 +281,8 @@ void vnc_client_cut_text_ext(VncState *vs, int32_t le=
n, uint32_t flags, uint8_t
>          if ((flags & VNC_CLIPBOARD_TEXT) &&
>              buf && size >=3D 4) {
>              uint32_t tsize =3D read_u32(buf, 0);
> -            uint8_t *tbuf =3D buf + 4;
> -            if (tsize < size) {
> +            uint8_t *tbuf =3D buf + sizeof(tsize);
> +            if (tsize <=3D size - sizeof(tsize)) {
>                  qemu_clipboard_set_data(&vs->cbpeer, vs->cbinfo,
>                                          QEMU_CLIPBOARD_TYPE_TEXT,
>                                          tsize, tbuf, true);
> --
> 2.43.0
>


