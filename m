Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839A8D29DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 05:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfWvO-0006Id-GA; Tue, 13 Jan 2026 00:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfWvM-0006IT-8l
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfWvK-0008EQ-Sh
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768281994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuMd1+Qvf4CuzA6yTM0NQ+oas0hdgFEL7bO1wUuMPGQ=;
 b=HeUMqJhh2gxmahKVpkjrQI3R8e25YcHoJnvV2pbAof964ys9kFJ4bPArKMr0Hu8JczQPdM
 wcnMWYAB/gBADjfXj6G9kaSTPXBMqySzj5o+/LKGZzGLITZHE10iJMhocAujiWYc//NkL3
 jKWzwldCNDgu4U9RgYiQOfiGwx5QDy4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-xb3bXaGtNLW39mCB1cZGjQ-1; Tue, 13 Jan 2026 00:26:32 -0500
X-MC-Unique: xb3bXaGtNLW39mCB1cZGjQ-1
X-Mimecast-MFC-AGG-ID: xb3bXaGtNLW39mCB1cZGjQ_1768281991
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ffb4222a4eso156353051cf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 21:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768281991; x=1768886791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuMd1+Qvf4CuzA6yTM0NQ+oas0hdgFEL7bO1wUuMPGQ=;
 b=I0GhWYp9wNFPQBuNT4PJLCsCwNIcmmrx45nFqdy1pi0z1K/eGhAHcFdUwynVbEoHoK
 Rb7WwbZEIv3lS4kZhnE+goWth0UHGVNeObzi2mo57uA3in+vdebx90MkQlnsyhEoEyK1
 a0LF3g4EZBgTJQXu+/LMmiXq6fkCUqLON8bxcnfpvHSSLKYiY5/a+mWkeQvT1cSODAAg
 cE2UvvBii7/KOgHF6N2FHyMLXevAPXh2AYxZoeCMx0A7H7WYraUWrXJL8P3GiqgN7TI6
 RELtfprK/yI4PeKDCBcncvLeS9USPtECMu7bv4/x8zd1UjiMobvghG16QuPkMOpwjy8T
 8D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768281991; x=1768886791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nuMd1+Qvf4CuzA6yTM0NQ+oas0hdgFEL7bO1wUuMPGQ=;
 b=PTzFEhHXQqEVSlTt/7753n6y5ncVOyCtmgFkRs4vK+TVIKDa1i+2nfqOFD9ChUKPWn
 E50cCy6VBdapTZ9BdhY0f2oKFAAo54D3xgwmmIv9vF3hGrM2GiJzafdUjBCK0E0ZHP5r
 Nj0/kWIZrZ7lSkXv9OMY0ll51IwbTgQ3MqPqE37qYbHXitUeA4ZbfDUFFWm1dOXhnq40
 F5OsOYwy1AvJufAZ86hvL0cpxPTMBXRdwGVN5l53uEHYRNpwiCegObWgaiO14YG6f5kM
 sXKh2H5QmtTw7PR7nI1DVx4Q5069eRK06LWI0iFb7esCsjs/89Kqo27pJjkxBbtv7G+S
 z1aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSlRwVoC2a0FgcMF+sTmidqSnJ9KRvtVSfGzfnM/9ujz/ieLmD24CmMxuXC/8z9akeatDYKNu6wZkC@nongnu.org
X-Gm-Message-State: AOJu0Yzp0TyFve9kpAPH53SmanMAvIEKYVaa85zMqSAjlT7mrbVjNmhV
 o8OsRbKSOoAZ62+S1EMHJZe2rs0TiqmEAjE3DhvDdKfjSQgoyvjFCc8YHfCczLLs7iJqbySKWvV
 lS+1QqCntpA7GoD2qDq/lBr4aPfPD+2BDjjkQeLZzY+e6pVYUqam3DfIIJIS1vEbP7bkw3425qe
 CrGMKGHMiDSo7+5/57eV9JNTrWRwOKlVw=
X-Gm-Gg: AY/fxX4jkrU46JaNURSA94NNESG/kdBCsdnXcTvvWmdywLgwnfK655hnhTpaqJEx/IY
 HWwilib3gVvaDXnioCTrjf79Fv8g2UcWwADMtXmzwEAeK0wPlXI8822lbKbJiqGffkUhQJr3KEt
 7uIwDe2Jfig+jRG8deSk30DGIA05e73Jws0vYD5FdQhMUbrp6jOH/KdXz3dGBWV4F3WnilSU5PJ
 7h8oDOlGU2aiBrHa17Cq8pzCQU=
X-Received: by 2002:a05:622a:47:b0:4ed:a6b0:5c39 with SMTP id
 d75a77b69052e-4ffb4a2f43cmr308309271cf.63.1768281991559; 
 Mon, 12 Jan 2026 21:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNuVSZSl8dUOM2nyM7pReP2sPPAkQhyBICCc9jz0MxZebzPnjCR/0308U8sEb0Cmz8WfprTpfMUOfg46P5lkI=
X-Received: by 2002:a05:622a:47:b0:4ed:a6b0:5c39 with SMTP id
 d75a77b69052e-4ffb4a2f43cmr308309181cf.63.1768281991253; Mon, 12 Jan 2026
 21:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-26-anisinha@redhat.com>
 <CABgObfbA_SODCgRFkX61nt+tdGK7txurUXo3yLbSuMfnjyyG8w@mail.gmail.com>
In-Reply-To: <CABgObfbA_SODCgRFkX61nt+tdGK7txurUXo3yLbSuMfnjyyG8w@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 13 Jan 2026 10:56:20 +0530
X-Gm-Features: AZwV_Qg2j1yT1Oaxd3FB2IH_8KYLvJ50-TUlBJKvN-QzZtwwgCxpfZURqTVmOIg
Message-ID: <CAK3XEhM2Mc7orgjb827v836e5Yh8w_TFJB_nQd_+zsOUa2dB2g@mail.gmail.com>
Subject: Re: [PATCH v2 25/32] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

On Mon, Jan 12, 2026 at 10:50=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> w=
rote:
> >
> > On confidential guests KVM virtual machine file descriptor changes as a
> > part of the guest reset process. Xen capabilities needs to be re-initia=
lized in
> > KVM against the new file descriptor.
> >
> > This patch is untested on confidential guests and exists only for compl=
eteness.
>
> This sentence should be changed since now your code can be tests on
> non-confidential guests (or removed altogether).  Same for patch
> 23/32.

I can drop all the xen changes altogether for now, if no one objects.


