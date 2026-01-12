Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038ECCF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLah-0002BJ-76; Mon, 12 Jan 2026 12:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLaG-0001s3-4j
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLaC-0000VP-7a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768238399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/79j6iZ8GygPD7Qnvz4ISA/UVU/GSE0d3luZMVts+k=;
 b=GFIGoGG1zUktocqUn/1Zp5tX0XrQeAvQ7Z80SFCl4/cZ9FkQww2QO5vlkoM0UX1nX9nIed
 cYbWIHEQoCaiSkcR3ycfb56oHAlMCBy5tNilvKkpcditZYWwVhf3PM5A0z7VEOLAQvNwbW
 cthLzUfzutj6QmYTzTbWqtMAsyC5cuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-RbBhkUF_MsiW-ZUWLK8tbQ-1; Mon, 12 Jan 2026 12:19:58 -0500
X-MC-Unique: RbBhkUF_MsiW-ZUWLK8tbQ-1
X-Mimecast-MFC-AGG-ID: RbBhkUF_MsiW-ZUWLK8tbQ_1768238397
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so39248875e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768238397; x=1768843197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/79j6iZ8GygPD7Qnvz4ISA/UVU/GSE0d3luZMVts+k=;
 b=kk5ek9a1zoMcRNa4m/NhwJwwoKdS0iE/nuxq/KLytSFP8gesbyoE4ADlDpLhuCqb4T
 7QDx1Igi8g1bgGrY/Nf3BAsYRmejdG1MSMVlqiqLUrGQI4UL0+SDg3Uk/ziRXPMUBVR9
 VqDzr3GegOl4TmFrHOYPTqfd0mjH22yaSzx7IFTxqtPF2JNLZ2NzcXQFIhTXgWMyLX60
 R0XvjLtKyTPZ4f7UAVfZgcgNKwH89nz9tpGqMuXlt1xhKJM4ihXpvJPVQvRW2LEyvzMI
 6pL47n3F95K0xeoxj8oxhr/aeI/FEiG3iakwj10jwwH3FoxTQtfUseZAMAGH2+dYLxjs
 XjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238397; x=1768843197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/79j6iZ8GygPD7Qnvz4ISA/UVU/GSE0d3luZMVts+k=;
 b=H0Ffrw6ULlpDhAGDU3BUf1uuFcVDYjp5aVWGNgnCoP+7Efz3rOGx8adYvd24rialHw
 v/+exGkRVK1hW/VlIltChY8Kq+ZrQBLhxhbW1LzKDw97JFWM6sLR0AcsZPGyBB97DGwx
 H07ly7Orb7IuY4TvpPbmRrfTkMoSqpkbzCxaouhfjjzzwWrQSfMIuEv4VLhmDqX7us74
 t396U7UzLFYgE+F2Ve9tlVv94El8r6Brh1/DAE/tnVUkzGT9aMRkTyaeh3B/YQvZLyR1
 rWMc3YJmAyWxlB1HdJeCO9g/s5qL+vbpzVZv44hh8BZ8THsH4FWlvpTTx5H8B6NwMHdc
 N7rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YQxEJWvRiB8N7+3AaKBYY6/XRkqu7MUJwWsmAiTQPcY0DeSZZG+kcCTVsLYQaquPBEyubf8Y7DO/@nongnu.org
X-Gm-Message-State: AOJu0YwBrohrXvgyFUt5Tg14/5QKPhw0IrhPKpSfdOI/xd9ksgY3p5SR
 Rc0R2hPppBlwueJBK/U4Du/PbRo85PcnsMkB83wdAO8a0PBzSRCzRgZJ62cLf22wWVMRFvXqbG6
 UKo0m6clJkZFXKoAe3EC8fBF+3q4dnRh7N8L3U8KceW5gNfuyWj4Zy9P8uacLAZugFAkm3RIP7q
 EaoZbihaS8fImjYGdm9vLN4GeVLmCxYIU=
X-Gm-Gg: AY/fxX5qmL4Yj/0m5o+clpTzhZNmY34bUZfd8XWKSWrre7COFiBTfBcCah1HceStFSX
 XwUWukfz/RWEc3i7yH6rcy8aeM3SWgqF9vEIgXb75+Dal8uIHeoN9dBPK3l5uGjydhK/h1FkWW8
 pkEjzKc5TJpSD0CyoWNrRSGqwXWr1WmV/dlEOZY7z8pVujfT3eg1sEyK5LAin778jWolZ7vewbf
 CghG/mVtcCgsTShS7iB/0Vz18A3MnUifzEuDqu4rCvSRybhCip/cHums8kT7YutBQrH1w==
X-Received: by 2002:a05:600c:6a95:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-47ed7c2843dmr1455425e9.10.1768238396810; 
 Mon, 12 Jan 2026 09:19:56 -0800 (PST)
X-Received: by 2002:a05:600c:6a95:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-47ed7c2843dmr1455195e9.10.1768238396465; Mon, 12 Jan 2026
 09:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-26-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-26-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:19:44 +0100
X-Gm-Features: AZwV_QirRKZFKxjgCZydqAV1KubY6QZS9O35MXViLqeftOcbpRGTDiqhtJGr6bU
Message-ID: <CABgObfbA_SODCgRFkX61nt+tdGK7txurUXo3yLbSuMfnjyyG8w@mail.gmail.com>
Subject: Re: [PATCH v2 25/32] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Ani Sinha <anisinha@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> On confidential guests KVM virtual machine file descriptor changes as a
> part of the guest reset process. Xen capabilities needs to be re-initiali=
zed in
> KVM against the new file descriptor.
>
> This patch is untested on confidential guests and exists only for complet=
eness.

This sentence should be changed since now your code can be tests on
non-confidential guests (or removed altogether).  Same for patch
23/32.

Paolo


