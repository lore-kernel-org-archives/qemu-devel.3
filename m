Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A83AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGpl-0002Bk-Mv; Wed, 13 Mar 2024 01:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkGpf-0002B9-TY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkGpc-0006Qp-2q
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710306430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pM3SwMIauMCPI8Dt92wSrnAm8oA2Jea9gq61TqjyA9k=;
 b=DzeWek3Kc4vX8A74bGQ+jXemoRCl5MDg+HqtYFBrlOwY78gSZ3ak5vYz3osfelSZkJF3Jx
 ldp+ycx5edz4dp0ip4OjVWMR9VnWwDun8tKDYfSlhF759ILdnKtcOCfWvUkqwCh6uwHtvC
 v6PH0m/MDekB4/0KoemRkvgdURe8ab0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-U1lSsYfmOhCSuKv4GqRg9g-1; Wed, 13 Mar 2024 01:07:08 -0400
X-MC-Unique: U1lSsYfmOhCSuKv4GqRg9g-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29bf071cc04so2381838a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710306427; x=1710911227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pM3SwMIauMCPI8Dt92wSrnAm8oA2Jea9gq61TqjyA9k=;
 b=w1jNjKEPdrh5FL5kzIL7f9vzi6HrvGVn9+2Px8A1fzxP+ye1SaVC4+unM6K6uZRgiY
 qQZRTajgRPcL338g83jJSx8Q1bqCZLKrepHMG//TUPNKXb/LVmzRIXJgeAfDUUk1Zw4J
 5gXqCxDNEv/kgNNEfO0tax4ZbZ3k27fwGPFBPeLaTMoY83u+9cZ/djz5zn+3uqMajtwK
 ChPVu3BLC1jkSLat7G3hveiFeNaa4NNEJkLfeVbY3FzUIhqF5vAZhACLWH4c39Knn4aX
 UFkaKq1UX9l+6XavjPj4zV10kNYDyw48wy5gO1NicQhFScSev7PVGEJ7ngIkpVzbiDno
 iTOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3mx88RBHgNZhXBapzRCc+7kMxwtRk0dZNRCXcH19roe4rzS8pA9THBvGonf6xNEIqIVFY+rMxvTnt4AIw37MvW/sOZbc=
X-Gm-Message-State: AOJu0YwJ2LL+j2+4cC4oUJBtX9p9JTOFP56k0pPg+MPonUvWynLJNshs
 oAZObpIuqxx/jvT9sqiWG562uZX4rReqWeZd2eC+Uvkd750gi88h87F8JcPPBdXvt8BY0k7GPMr
 acd2Xu2GdbZb0GheTBEcCMNK9vWx2ZwQvhlMKnIcggVk2BOXP79Hw+idTwyX7fjoriAqEyJQHFj
 0bJdU7WnxAC1zHLR8QVl3yKfYZ44A=
X-Received: by 2002:a17:90b:1d92:b0:29c:5ca7:8bee with SMTP id
 pf18-20020a17090b1d9200b0029c5ca78beemr1157394pjb.43.1710306427426; 
 Tue, 12 Mar 2024 22:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCYlVs98WS9to9ahPFseITny1doTIYT5GKTvmNyFD4ARZoRj+48f+Epuov581zwDlyDdG2bpAYp4jlgMmNv+U=
X-Received: by 2002:a17:90b:1d92:b0:29c:5ca7:8bee with SMTP id
 pf18-20020a17090b1d9200b0029c5ca78beemr1157384pjb.43.1710306427139; Tue, 12
 Mar 2024 22:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
 <CACGkMEs9B+7SEy1naQCQwXQDd7bzRZGjxv2h_QHx8g_az6E=Fg@mail.gmail.com>
 <CACGkMEvMoK+MZx7WkMzzVpyHw+agac38Td-aVq3Ygwb4jNhXmQ@mail.gmail.com>
 <CABcq3pEqCdha49FAs8knQDcp1RzA6MFxC3zwRU2oyvHcX_7EkA@mail.gmail.com>
In-Reply-To: <CABcq3pEqCdha49FAs8knQDcp1RzA6MFxC3zwRU2oyvHcX_7EkA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Mar 2024 13:06:56 +0800
Message-ID: <CACGkMEs9vd_AmG9wyBvoGMg-M-Apc+EVhod7Hd9YaSRzn7CuUA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] eBPF RSS through QMP support.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Andrew:

On Wed, Mar 13, 2024 at 7:11=E2=80=AFAM Andrew Melnichenko <andrew@daynix.c=
om> wrote:
>
> Hi all,
> Apparently, eBPF code from ebpf/* can't be a part of the 'common'
> library - that breaks non-system/user build. I'll change it to be a
> 'system' library.

I've dropped some of the tracing as a workaround (due to schedule
pressure) since yesterday was a soft freeze and I don't want to miss
it again.

The pull request has been merged. Please fix that on top (add some
tracing back probably).

Thanks

>
> On Fri, Mar 8, 2024 at 10:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Mar 8, 2024 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Feb 26, 2024 at 6:23=E2=80=AFPM Andrew Melnichenko <andrew@da=
ynix.com> wrote:
> > > >
> > > > Hi all,
> > > > Jason, can you please review the patch set, thank you.
> > >
> > > Queued.
> > >
> > > Thanks
> >
> > This seems to fail CI at:
> >
> > https://gitlab.com/jasowang/qemu/-/jobs/6348725269
> >
> > Please fix this.
> >
> > Thanks
> >
>


