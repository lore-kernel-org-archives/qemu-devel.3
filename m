Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E9FD9E34
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 03:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvoOf-0008PO-Gp; Thu, 26 Feb 2026 22:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvoOd-0008PA-VQ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 22:20:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvoOc-0001fW-5v
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 22:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772162404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFgxT1HFchnFlGhvCR8TAEDeaBdoPDuDWAGteaYfq24=;
 b=UAcIBRAQVr1U8J0GSIwbOrrhROiJQNW49QQsCxbCPZQSL4VspugSjWMuO9gA46FHBSXXJx
 WscbPU/vLOOBXkWx9ykh5pBnyM68rGQ/TBra5vELEd2NKLm6pcGQ5nIXsbo/qwGils54QN
 ew+p61GD59SRYa3BajH+oFHIcGa70ZE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-wFz1NOShOKeBeuwef1XkFw-1; Thu, 26 Feb 2026 22:20:02 -0500
X-MC-Unique: wFz1NOShOKeBeuwef1XkFw-1
X-Mimecast-MFC-AGG-ID: wFz1NOShOKeBeuwef1XkFw_1772162402
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aae146bab0so23238975ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 19:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772162402; x=1772767202; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFgxT1HFchnFlGhvCR8TAEDeaBdoPDuDWAGteaYfq24=;
 b=ZKWdGVeCycNlgpcMe4LxBjYoDgAuleSUt0xvhLhZnI4jYlg9FNbVfVChsr1QA55rqb
 9HSXLifxqaWbHRbTeRKxSOTOtm+4bdAc5VUnGPGAAVVoARVSi5S3jxMQKojwntmOs1RN
 4FxVSGHJn9r/xpL/LriUWxjlgZmZxEYAtuAUS/TVmZLEnSjfbq9Pqg1J9LSzWEDXPcPu
 HjZ07u6gXJ+uQd5S/IwWWv00IZuw2xev7HbHnh2czffu6nPDVPG8KzcjYSDOy2CGYQuP
 PfNI/m401IJ/8FY9aVEfuFEZaxt5S8La+yQUHV+IqhnMjQg3B1O4DQRIHGGAwPgzF3yZ
 5aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772162402; x=1772767202;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFgxT1HFchnFlGhvCR8TAEDeaBdoPDuDWAGteaYfq24=;
 b=igsI+39zRQljjKEBs2XMqBGqWhZIKUN6ryTl1OP1T1cdmudHl8ub+paxT3e6rkllwR
 laB8c0dDN2olAsQTC2Ld2SMigyOzzUXKtHqLl4dbDqE2dQFmSpjHc13qxsvl7juDOOdy
 nwEdc0pwlc2ns6BwXtsZ+bdyct5uJdKRGBca1bAwB2sWF2Twyxaz6XT90oWoz4wXzfk4
 HQf54NER8GTfMYrNI6FnqFZGPvYOd5GopaH2JKRT6fQ8qPZpOgf1q4VsSuyEPyzmPyld
 3BGPxI2noE/giTTjN9xEvPqT6++3e/O1aWDFx2NMnoAPJs8/J1fHa+jViVX89ZvF0AAN
 mGFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUYCOR7btCEGHJ+knGMh7qhuB5AhAUpGLSbas4s9wyeW40QiS9VlXz/ogl6EO3JMJy98+N5SF4wuKe@nongnu.org
X-Gm-Message-State: AOJu0YxzOFsO4Id2m9hNW04/lsoCFk79CSAstma4ElI1XrcST5wg1hnK
 wt1z/t16zHpNxGueP+WJwtl8QTw9gSOuSEVk1UUNClZq3EyBd9K8HPRd7ZFeVgxyTbX2do2nzY9
 4kjJmXlW/Lf69xA8h13A09KyU8XrYY7SVeN9FjV1gOWTNhbXnXUwJ8s0W
X-Gm-Gg: ATEYQzzWnuKb7XL6hBrpL9CCQfFFCrlErgIxsfr2T0mQOUTCoOkW4FnROEMg0O6LBu7
 1bA8+tpXsfdsI+5djirP+08tG6VN60v5k6NBRpzmIqJnFq/5RfdlqOPtmZOq4ygb3CqlEqGW8GN
 uurF4iBUwsu7MUlCIw7OaQCN9iuFnng+7F51cPJJhBLy+qgcanBo2/fdvWCsOQulUaG/zqc4zDA
 X+V9/ZWGTdiFRNLEGw1UEw2F/my/OuunHtIofZU/jc3cosernFzm5A87STMjq4/VKP5RykjvF/A
 idzStkr7Ln12X9RHjZmejgOIpKb5m4UefYBDI0/WUibN8ajvDko5UXJTUDN7ulb4ZRAM5/SKOuz
 OmLFck9ib1nG+lIIYBnfmGZ1rcQ7ps9IHf+Qk2N99QCHQHzaWB8e4AGwaIZSmRGHr0iskLjYtQ9
 E=
X-Received: by 2002:a17:902:e889:b0:2aa:f2f3:bcb6 with SMTP id
 d9443c01a7336-2ae2e3cca5emr11637175ad.6.1772162401445; 
 Thu, 26 Feb 2026 19:20:01 -0800 (PST)
X-Received: by 2002:a17:902:e889:b0:2aa:f2f3:bcb6 with SMTP id
 d9443c01a7336-2ae2e3cca5emr11637025ad.6.1772162401044; 
 Thu, 26 Feb 2026 19:20:01 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb69f98bsm42583655ad.56.2026.02.26.19.19.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Feb 2026 19:20:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <54c74ac4-3eca-483b-b56d-73c6e7d17c3f@redhat.com>
Date: Fri, 27 Feb 2026 08:49:45 +0530
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D3E88B6-D89D-4067-B014-11DDF68C4B8A@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com> <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
 <54c74ac4-3eca-483b-b56d-73c6e7d17c3f@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 26 Feb 2026, at 10:53=E2=80=AFPM, Paolo Bonzini =
<pbonzini@redhat.com> wrote:
>=20
> On 2/26/26 04:46, Ani Sinha wrote:
>>> On 25 Feb 2026, at 10:59=E2=80=AFPM, Peter Xu <peterx@redhat.com> =
wrote:
>>> Hi, Ani,
>>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
>>>> Currently the code that adds a migration blocker does not check
>>>> if the same blocker already exists. Return an EEXIST error code
>>>> if there is an attempt to add the same migration blocker again.
>>>> This way the same migration blocker will not get added twice.
>>> Could you help explain why it will inject two identical errors in
>>> the first place, and why the caller cannot make sure it won't be
>>> injected twice?
>> Likely due to a bug in the code. For example if the init function
>> that adds the blocker is called again and the caller does not handle
>> the second init call properly. This came up as a part of the coco
>> reset work where migration blockers are added in init methods. They
>> need not be added again when init methods are again called during
>> the reset process. The caller can handle it of course but adding a
>> check further down the call stack makes things more robust.
> Since this is the last patch, is it okay to remove it at least for =
now? Can the situation actually happen?
>=20

Yes you can drop this patch for now. When we get consensus if/what needs =
to be done, I can send another fix.=20

> If not and it's a programming error, even an abort() is okay.


