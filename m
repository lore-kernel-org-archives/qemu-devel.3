Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD38F3C27D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzu6W-0001nq-S0; Tue, 10 Mar 2026 06:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzu6V-0001nb-H8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzu6S-0007qo-UN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773137656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCpUoR5PTVv9r/wpaG6FtqiqdVXagf3nOaXnlZ9IrH0=;
 b=I+DWmazGw013vncoplVtwt+5SAMiYzX7uxQqJYuR/taJXkg9gB6Ow8h+jvcCaf8vWtcXGs
 oHvVBQ9OWrMEgCf78bR36OGKN5q+1NbAMtlI5hoAkL9b/l0hvlUS1E9oy3GRq1d23ZeMNm
 VJ0M6X6TsedU+yRoZj79b7Kxa8Uxmbo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-NYG9NTLMO0WV5j61kiLJbg-1; Tue, 10 Mar 2026 06:14:15 -0400
X-MC-Unique: NYG9NTLMO0WV5j61kiLJbg-1
X-Mimecast-MFC-AGG-ID: NYG9NTLMO0WV5j61kiLJbg_1773137653
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-bce224720d8so7323206a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773137653; x=1773742453; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCpUoR5PTVv9r/wpaG6FtqiqdVXagf3nOaXnlZ9IrH0=;
 b=EnaZHgizwuCVqIglFKF2D6UsD1ewiSJ64q8Y5uYzU+FNKXztDzZb7JgxX7Wp6q8gmt
 VzvdZmauWaEzkNcxrRwxykd8Qm9TNg7CYN2HEZVi/XBq8361aeWAE+hm7nWPASLsS0C9
 zdlgMgj9PgTsVSPgZyeb/BEzJE1JZOuDLUvpyhozvPFN80Jc1/m5KM9blNHTGCkiepYM
 P21ObognEswxFfWoOGofsMsUnZvPQGbBXc5wDvfp2lKnZfxT+MvBNRBTGY+VWHZGx1o7
 nIpgdmBM/k53Jlrr4lLcpO5Wp58vPR3GHfAgaWPzsdLlbayUEEw4wAPO4U48+8DGhMHf
 uZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137653; x=1773742453;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kCpUoR5PTVv9r/wpaG6FtqiqdVXagf3nOaXnlZ9IrH0=;
 b=mwGSnGclQ3X1zpTASaEc70JArXZGK2GzYndGpWlAwn6YVisn6HSNTm+YuvwS4REsV8
 3PKbvpAoiQC5PIGg2yS4RIobXhgR6q5evw8BfBIELulDD3QZqzLEubInV78mE5UNNdw9
 RGCMCyIRrskX3/8G5DxeRC+jdsXCdaNiL8Fs4vDBaa2y0xZvEhgtCfmgW3fUlS9C9G9B
 8mjhhvf6msGDARb0K5QkIrgi+k7vaH3sn0R1ft7CPPxqouRDay/J57uydXJt1igjMY6g
 YKn34VlUYWiTbpChAebKdNsX/sv8AVZh5h04KaEk2592bwv3Z37SFoplOJaVcIGzLM+9
 9GWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdN0Cwoyy8BT4wr2fVFs8V2P9c2dPM0IukDaskGL8KefCB9kTC/h21erbo7hDeXeWtY5JFGfBNoRbe@nongnu.org
X-Gm-Message-State: AOJu0Yyi9KUXT0uQOXELkRAwZLa0vY3e1Mjsafs53BCpEDAIjIiqTCy/
 C/pn5IJwqwe0EjPCRRY7rLjnZWuirPf+olkgKb1JgRxFaSN6pLyyzrIDMpYnxbd/Hg+FF1QG80Q
 ZYOgL+BFIPCUil90cjahflsJvxS8jVnk686ULZwi3urYxOqaOt81hbOWw
X-Gm-Gg: ATEYQzysiwIIKeZ2cYrdzuqXMSQsNI7bCTw7xQqdn25dCHQpIGE6bbspctTwcKJqQcS
 E7CLUy1yy+mfS4eHfInHDHnHLq9zOQSifrJKi3w839tu58iV6Sthdgrny3LUNmLgmf1m7ni7kSs
 aHJXQ1Lh15WBjYon7xg9r+t3RIRvRXBYNvjGPhARQ4/8EVHpHDd0dofYB3bELvoK6v9+rhO+NC8
 rbkU7jw5lOfvja7PS40n4f1UVFdqUZGBR8ehdl4Uiy23351VujLacrnoikhnrJeGTEgMgtu5HfA
 zXp2y9BNRoBZWnfL4i/3uZjbsF7uwQF4HGNs8Fy+yNsSoiLbWBOvWt02qotICD4z+f4Q6u9U7N3
 rYlCyx3mtKcTFT8wpcqQEdkvfE8J1dpv/RAoPUtPbnux8mAVS2Kz7LDthwycWLK1YnCl6e6i3/D
 I=
X-Received: by 2002:a05:6a20:7294:b0:387:a311:3825 with SMTP id
 adf61e73a8af0-398590b3e3cmr14483883637.61.1773137652938; 
 Tue, 10 Mar 2026 03:14:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:7294:b0:387:a311:3825 with SMTP id
 adf61e73a8af0-398590b3e3cmr14483856637.61.1773137652568; 
 Tue, 10 Mar 2026 03:14:12 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c739e195acfsm11592652a12.29.2026.03.10.03.14.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Mar 2026 03:14:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] migration: assert that the same migration handler is not
 being added twice
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87wlzkknm1.fsf@pond.sub.org>
Date: Tue, 10 Mar 2026 15:43:58 +0530
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C0115AB-E428-4906-AA39-79B37F84E38E@redhat.com>
References: <20260308100148.162503-1-anisinha@redhat.com>
 <87wlzkknm1.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 10 Mar 2026, at 3:33=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> Currently the code that adds a migration blocker does not check if =
the same
>> blocker already exists. Assert that the migration handler being added =
has
>> not been added already.
>>=20
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> CC: Prasad Pandit <pjp@fedoraproject.org>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> migration/migration.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a5b0465ed3..840cf0dfe2 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1702,6 +1702,8 @@ static int add_blockers(Error **reasonp, =
unsigned modes, Error **errp)
>> {
>>     for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
>>         if (modes & BIT(mode)) {
>> +            assert(g_slist_index(migration_blockers[mode],
>> +                                     *reasonp) =3D=3D -1);
>=20
> Indentation is off.
>=20
> Have we run into such extra additions, or is this just out of caution?

Out of caution I suspect.

>=20
> What would happen if such an extra addition went uncaught?
>=20
>>             migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
>>                                                        *reasonp);

I vaguely recall multiple blockers causing some crash.


>>         }



