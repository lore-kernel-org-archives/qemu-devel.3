Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BBBE87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHHd-0000P2-Pt; Tue, 03 Feb 2026 09:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1vnHHc-0000Or-Rc
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1vnHHb-0002xF-6d
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770128493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6PgyRQUG6PSHGaM86Hhxj3oH60Z7cdKmOwOHVqeD9I=;
 b=hluc0tjZxwqJdqFBwynlQNyDHxbRDpPUL/wdA7PD9PzGxzyGYx1X4w4XPmT2qm3sYFUzcn
 4F7JIIOWlRFK/RDfS2C/BehZFv982bg77m3rU7uacDJasuM3s+vKkRpfLnAv7atPeMlBUZ
 DOrW7hbclQopzCsFHytyfHFoeQx+whI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-HGEjOfwIPf6_bJ0R-xH9EQ-1; Tue, 03 Feb 2026 09:20:25 -0500
X-MC-Unique: HGEjOfwIPf6_bJ0R-xH9EQ-1
X-Mimecast-MFC-AGG-ID: HGEjOfwIPf6_bJ0R-xH9EQ_1770128425
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79402e48414so90775787b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:20:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770128425; cv=none;
 d=google.com; s=arc-20240605;
 b=F/rKPw6SpikGFGKDXgYesN3Pmjt4RddGCu8L1kJVupUNdSd9w7zf3QcuREMaWssUSb
 Xv50+M8LkUi68NrpGZjNAHE7kgBNyAnsdJjzkjpmmp9g3Cg7UYTjkWp6LWkO/15B4DBd
 u6bki2ujo/d/Qatk8dU9RraeNDhLjA+M/KBMgdiZXg4VAXs29FgBsrsaSQIO8HjqC0Ho
 IdfAIzYAnAPllp8N6eZkW/tK5uB+gq0A9TbcBx6RFKzIElPh791BmfIyJ7KcCK1Tjwhc
 dnfIYJWbH6TIBPvlYcoQSKVKwGtm5oRLrlLBdUUqGpZo6E1KUAoeKL4RnMQ59BBmaaSe
 B1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U6PgyRQUG6PSHGaM86Hhxj3oH60Z7cdKmOwOHVqeD9I=;
 fh=bxFAbL+qTgGhcJxkLrumG8brvnXhrj8dpItPExknDx0=;
 b=lv7XIvtS0VgGmVWcopwZPHTjRpPkduYtqjVqyTmcrxJYcg+0nYIDW5I+D8DBUcmPDf
 fNNpgEL7QO1lhKoE/gArKpUCFhkOYblDscposAs9HVeus8ZkgiNQtME6SeGUoA6lKYGp
 Pn0S9tlx9Mi/6w8HPTBHQ1LSgYpgmSzBajBzjvh0Dl/crLTiEE4ClKnNNvv44uj9+VKu
 N1obT203AxYBXVfSUHw6TylM1ZMJcI8XQUl4mIJ4zm+qoZDRCHqmQPfdYnHMCtgoUpUi
 FPchrpvLRnCfPi5cVbqFBxuCJKt25fXvxuShCRKwUC6yxGOx9i01J3QOhElkX4BkMCGA
 baAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770128425; x=1770733225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6PgyRQUG6PSHGaM86Hhxj3oH60Z7cdKmOwOHVqeD9I=;
 b=R0z0u4vng1zuI603rje07gacARgE/Irbb1hXGOwotFg+Lqof3AcGagHH6YBbTPVtCZ
 tN4OxYX73s33S20O3vsnTysJ1gnrG8ZKoEQ7NlnbvcUD2O2Gg9AL3RgGpu1kpXLsMal2
 G0sVu7TpyXJY+ANV0i0HLIXOeq5vTUmYtz87lS7+CHWKbyPKC5yIj/LmUdBR+FzSVibO
 RwYRSuM65UGD5OZAwcIrt1+VLm9ful8J/rvb38Ig6eXhgXuSPeGy6PZnKWqTvujIyJkc
 BsOmpr5yWbYQW5oDFV3olUYkW1Mvdr/4lIBYA5r6+i92onRODFpX8VQlvTWJyRBTnCBF
 Vpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128425; x=1770733225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6PgyRQUG6PSHGaM86Hhxj3oH60Z7cdKmOwOHVqeD9I=;
 b=BWOs8gigJBpcdcG5tnglXfK8r24n9W4mIKUMCTBYL/7Dh5uJANcTaNIJXGNDSdW1Xg
 FX1Rf5hlK0fp+dXllZ/I8G8226VHijvyHjegCumUeEnUyPQcgLcrZN3io2YO2Mz1GvQl
 P9WDwjM6wFVnv4PggPhkMl1SP5He21RDx9/hWbGVSY+yUfHEKVOi1mGlfJFy4lJkz6MY
 FkAuR+DDuI9w0f3eQYG3u8zPYIgidV+taIge99PqNn37G3ywAvwUQnz3e0QdgBLg8h35
 b/S4tmgGUPtC1n5qcrFLva0DpZTPFdXG8uxIws6rjhXTkNWFirZTNl4AaSAev0a4cUl4
 jh8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsF+/aOeHEM7lA2cQTM+1hBlOGRJNgkcyZ9nsj0dURqcCnhPA47sG20+mpxyI+KAMLozK1hxwA6rc8@nongnu.org
X-Gm-Message-State: AOJu0YyqJkXRvRZpVzUfkgel+ipv6mmO0rqstBhB8fVkslHlRR13x89p
 j6lhil4jDJZIWoB9Le663yMXYbzfJRE77j3StY6dWhUQu1/jdSR6zfEZsePCdOW/5fle76eUfr5
 Rceh/Iiv410L0GPqqhJmHvCZ3uBQ93a3PPaVHxJUee4nPR6eIOmDlN41qVyC6U62KpOs6PK1z/M
 3wyWsxPHYpjcWh5g9+68AMQ8CsiXM/G88=
X-Gm-Gg: AZuq6aJBZdBwbWXwTeWL8jjHbVIT1Stu6dhtyT5XSKZSfpv2NkDKTFSwOX49BMjCES6
 sCoAZi4G/ZWjBbxv+Nf6MGGmrH324SFKbwNJaft4jLGkoDmd3tfWurWoRBap0qVMLxECiMOZYO1
 Uc3VnUOySngCfou7bFeckrUDpU4mCU7gvJbWpLrM2ML1KGr/ugD5hRdxa/wKCM+Qrn9XgGWvR4n
 s3ECeh78edE4HdSf2H/k0fDZ/zsWLYMA46F7icneLmR2UFD4tzlgTKomfqn
X-Received: by 2002:a05:690c:a91:b0:794:2fed:5370 with SMTP id
 00721157ae682-7949de6e771mr132261617b3.4.1770128424904; 
 Tue, 03 Feb 2026 06:20:24 -0800 (PST)
X-Received: by 2002:a05:690c:a91:b0:794:2fed:5370 with SMTP id
 00721157ae682-7949de6e771mr132261317b3.4.1770128424414; Tue, 03 Feb 2026
 06:20:24 -0800 (PST)
MIME-Version: 1.0
References: <CANc8XmBVnkbrsJ+DMKXA7HhepStAPHRpXOH8fB16e=bghPOsqQ@mail.gmail.com>
 <CAPMcbCq2oOYXo=O0D0fdBSG-vB7+q1=VtEqQpHqSzFU6+5Sq9g@mail.gmail.com>
In-Reply-To: <CAPMcbCq2oOYXo=O0D0fdBSG-vB7+q1=VtEqQpHqSzFU6+5Sq9g@mail.gmail.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 3 Feb 2026 16:20:12 +0200
X-Gm-Features: AZwV_QgCRw_yrGQnOwfaPN81_vkKqZmyJHZABHXMkhQjalD99Ro9C7yvrRMKRlk
Message-ID: <CAGoVJZz0w-7gsB+nmZ79kf1cDtUXoPe6UQAMDUuXKA2pj398BQ@mail.gmail.com>
Subject: Re: QGA fsfreeze blocks QMP: need async fsfreeze or alternative?
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Noam Assouline <nassouli@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, 
 Qianqian Zhu <qizhu@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Noam,

I think Kostiantyn explained quite well the deficiencies of the current qem=
u-ga.
I can suggest an alternative - there is a virtio-vsock to SSH bridge
for Windows. It can be used to develop a snapshot mechanism that will
give you more control over what happens on the Windows side.

Best regards,
Yan.


On Tue, Feb 3, 2026 at 2:58=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat.=
com> wrote:
>
> Hi Noam
>
> QEMU agent was developed as a tool with a synchronous API, and adding any=
 async commands requires a redesign of the API. QGA also does not support s=
ending any event to the host.
>
> First of all, if you send 2 asing command "file-open-async" and get 2 res=
ponses with FD, how can you know which FD is for which file? Yes, asked abo=
ut FS freeze API, but the idea is the same. FS-freeze allow to provide a li=
st of volumes to freeze, so you can have 2 requests to freeze 2 sets of vol=
umes. And get the same question.
>
> Regarding multiple agents, this is theoretically possible because QGA is =
an independent application. If you run each QGA instance with a proper diff=
erent state folder and a different communication channel, it should work. T=
he main problem is that QGA instances will be independant and when QGA1 blo=
cks all API execution because the guest has frozen FS, QGA2 will allow any =
command, including FS freeze.
>
> Unfortunately, I have no good answer for you. Windows VSS has a lot of li=
mitations, and we are trying to somehow work with it. Windows VSS doesn't e=
ven have an API to report a FS state, so QGA builds and uses internal knowl=
edge that will be out of sync after snapshot restoring.
>
> CC: @Yan Vugenfirer @Qianqian Zhu Do you have any idea?
>
> Best Regards,
> Kostiantyn Kostiuk.
>
>
> On Tue, Feb 3, 2026 at 12:23=E2=80=AFPM Noam Assouline <nassouli@redhat.c=
om> wrote:
>>
>> Hello qemu-devel!
>>
>> I=E2=80=99m working on a KubeVirt fix for Windows VSS fsfreeze timeouts =
(PR #16653). Up to now we=E2=80=99ve relied on libvirt=E2=80=99s default QE=
MU agent response timeout of 5 seconds, and that often isn=E2=80=99t enough=
 for VSS fsfreeze to complete. This PR proposes increasing the timeout to 6=
0 seconds so the freeze can finish successfully.
>>
>> The challenge and the reason for this email is that qemu-ga processes co=
mmands synchronously on a single connection. While guest-fsfreeze-freeze is=
 running, the agent is effectively busy and other commands (e.g. ping, stat=
us) will hang until it returns, which can impact pod readiness probes. I=E2=
=80=99m checking what we can do about this.
>>
>> I=E2=80=99m mainly looking to understand whether this can be addressed i=
n qemu-ga, and to get guidance on the right direction. Is there a supported=
 way to use multiple agent connections/channels, or is an async guest-fsfre=
eze-freeze with a completion event the more appropriate solution? More gene=
rally, any best=E2=80=91practice guidance around Windows fsfreeze timeouts =
and responsiveness would be very helpful!
>>
>> Thanks in advance, and cc=E2=80=99ing qemu-ga maintainers.
>>
>> Noam
>> KubeVirt Storage Ecosystem team


