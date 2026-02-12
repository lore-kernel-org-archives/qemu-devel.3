Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014ACEDF05C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSC8-00070r-T6; Thu, 12 Feb 2026 03:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqSC7-00070T-6H
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqSC5-0006py-DX
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770885418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S28mvsxUwXYzebAuxeqnovFXr3Jd2l2hZVxQKKrLYk=;
 b=Z5DVxpTGkp7oEWSVlZFf8ZDF+9vU3nDBY3d0QtEjR/8f3Pj70ZnA1VDta/FGggDe0HDFZg
 4cK2YY5Fo6Ra2a9TkDOQ4VJCuTopauAgkDu8YBBS8xOW1cgfTfg0pwNIKpMEsQGPTGh/01
 xYsV1M/ryD8HN0b+YmHdmbPk8oM+nCU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-wxx7wmONPFuYrkzXaRfrrQ-1; Thu, 12 Feb 2026 03:36:56 -0500
X-MC-Unique: wxx7wmONPFuYrkzXaRfrrQ-1
X-Mimecast-MFC-AGG-ID: wxx7wmONPFuYrkzXaRfrrQ_1770885416
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c65d08b623aso1179721a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 00:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770885416; x=1771490216; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S28mvsxUwXYzebAuxeqnovFXr3Jd2l2hZVxQKKrLYk=;
 b=qoc630giEk2jSPjIxLW35BDDsIxVeCjes7eB7+S5iTVq65xKkkziO1vMXi/+2NEAir
 T282zxPKsfYMG9WmHyzq9t5iOvVrHP547ZhRBGH7NO7NYiv+oejsleAHom0vsURiq3x1
 TpFuuQrLA8fyurPwEZQVfruG2hnINmxLjEDcCjAIlmVzNhGe6P5gKYlpsZIBNTszE4VR
 Ym81USDidRrlGrinVAg5SPmp09IRRW8dTdoT2IWg1m6whHeEGZkNoofIjZ8+RzBSsg5n
 ABvO1LOArUFJ5ebRJtnDWKjfEyUYbFuX00XmGJylO3RZfZRG24Dg/k+JPTVFtx5jXLUf
 +dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770885416; x=1771490216;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8S28mvsxUwXYzebAuxeqnovFXr3Jd2l2hZVxQKKrLYk=;
 b=QSmzR+O9u38aVeG2ERvuFCcLS4mnP5DyXTeZe0u9fOkBXVcqjc6sIlB5HTAkyWmqs3
 w5j82/zGeZF2ZJJr/s3Vco6fCmWmBcTHZiebOa9HMc51QAX194IuFrvuSWN2LFHhWS4p
 BijmnIAuq15nBUWM6GembvSSzyAkxhe/gDKgSiArd3tAa4S6cA+hGoeI6M5nFLxxhv7e
 h2kcN9exF/Us+uaaCGDv2eUMppVgyzJ/3WjO+TvKh5WQbmpce3F/v3RGG1XIRyD81o0C
 MkgxuJZsW8cPQHqE4MH709YUQsbNh9PGRhD3Tmu5KktnnRWyIV5+V3qrGX9N77KefYqF
 JJHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUozIv/C9h8iCVl88yMo2BvqdQfmmWikOhc34n5wD+GUBqsVgZfkZBqH67GofKOp40MXYVG+yxkNb+Q@nongnu.org
X-Gm-Message-State: AOJu0YylYgvrs44FixOn/lcaMbar5/XQdqmwCI6QN1siHHY9aNEl65XP
 JeCaLd+DwPX4QARaiYX+RsUv57e3qyn3BrXzobkeDWebGCJMbPliTWY3TOWPDK2yUoQaJD8g7SY
 TGsPxx10yfq0mB6+/XVViqPqsEkVl1zNJ5jn8Sd7Zdjs5GUOQi/LG46g6
X-Gm-Gg: AZuq6aL8Ri+VFdSqLX/szqJQ/O4JabyzQZ1a3N75Cf+SRnZ/zZbYNQodf17fXMPMapJ
 xUkYWSpTm/6l7XX8igLS9fBE9AarneAuSbq7+N+Nv6Jm01XvBR23ZQge/fRqNs4WotEaBBiET2V
 ng8z9jEK1k+jvSv1Jfx9r7FwruDl18cqzm3bDUEE7urc5PRdTlW3c0ZRUNEonpHn47ZYoBFvrqS
 LlCbkvYJXNZ96ZFoPS3wn/2JRU4cKjtQxN+NgRfKRulap+QEd5xEFhyxO2G0JDHxHDcN1Hsz1ZB
 eraG67O+kpYJ1SyayM4xZf+K8V7ze1LrveyEs0VJU6zTNwlFVAX53r5Errep1wiTuUh2Ls0VblK
 AX1xIw3F7EH3QvefhQrrlzSnIDgE/gySeS39UtYZXlQIOYi92jq+gJzUQqQJ/mCrnnIRL2w==
X-Received: by 2002:a05:6a20:c90e:b0:371:8e6d:27f9 with SMTP id
 adf61e73a8af0-3944a70c127mr1558733637.33.1770885415675; 
 Thu, 12 Feb 2026 00:36:55 -0800 (PST)
X-Received: by 2002:a05:6a20:c90e:b0:371:8e6d:27f9 with SMTP id
 adf61e73a8af0-3944a70c127mr1558716637.33.1770885415279; 
 Thu, 12 Feb 2026 00:36:55 -0800 (PST)
Received: from smtpclient.apple ([122.164.27.113])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1967ca7esm4180279a12.3.2026.02.12.00.36.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:36:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v4 17/31] i386/sev: add migration blockers only once
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAE8KmOwa1M_F9Qfs-XXRhaJZx7jiwQDfwDk7U2shJi8SLa+y9Q@mail.gmail.com>
Date: Thu, 12 Feb 2026 14:06:39 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C39045F-DF1E-4E9A-8ECB-AE24C766F002@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-18-anisinha@redhat.com>
 <CAE8KmOwa1M_F9Qfs-XXRhaJZx7jiwQDfwDk7U2shJi8SLa+y9Q@mail.gmail.com>
To: Prasad Pandit <ppandit@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 12 Feb 2026, at 1:20=E2=80=AFPM, Prasad Pandit <ppandit@redhat.com> =
wrote:
>=20
> On Thu, 12 Feb 2026 at 11:58, Ani Sinha <anisinha@redhat.com> wrote:
>> sev_launch_finish() and sev_snp_launch_finish() could be called =
multiple times
>> when the confidential guest is being reset/rebooted. The migration
>> blockers should not be added multiple times, once per invocation. =
This change
>> makes sure that the migration blockers are added only one time by =
adding the
>> migration blockers to the vm state change handler when the vm =
transitions to
>> the running state. Subsequent reboots do not change the state of the =
vm.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> target/i386/sev.c | 20 +++++---------------
>> 1 file changed, 5 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 66e38ca32e..260d8ef88b 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -1421,11 +1421,6 @@ sev_launch_finish(SevCommonState *sev_common)
>>     }
>>=20
>>     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
>> -
>> -    /* add migration blocker */
>> -    error_setg(&sev_mig_blocker,
>> -               "SEV: Migration is not implemented");
>> -    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>> }
>>=20
>> static int snp_launch_update_data(uint64_t gpa, void *hva, size_t =
len,
>> @@ -1608,7 +1603,6 @@ static void
>> sev_snp_launch_finish(SevCommonState *sev_common)
>> {
>>     int ret, error;
>> -    Error *local_err =3D NULL;
>>     OvmfSevMetadata *metadata;
>>     SevLaunchUpdateData *data;
>>     SevSnpGuestState *sev_snp =3D SEV_SNP_GUEST(sev_common);
>> @@ -1655,15 +1649,6 @@ sev_snp_launch_finish(SevCommonState =
*sev_common)
>>=20
>>     kvm_mark_guest_state_protected();
>>     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
>> -
>> -    /* add migration blocker */
>> -    error_setg(&sev_mig_blocker,
>> -               "SEV-SNP: Migration is not implemented");
>> -    ret =3D migrate_add_blocker(&sev_mig_blocker, &local_err);
>> -    if (local_err) {
>> -        error_report_err(local_err);
>> -        exit(1);
>> -    }
>> }
>>=20
>>=20
>> @@ -1676,6 +1661,11 @@ sev_vm_state_change(void *opaque, bool =
running, RunState state)
>>     if (running) {
>>         if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
>>             klass->launch_finish(sev_common);
>> +
>> +            /* add migration blocker */
>> +            error_setg(&sev_mig_blocker,
>> +                       "SEV: Migration is not implemented");
>> +            migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>>         }
>>     }
>> }
>> --
>=20
> * 'sev_mig_blocker' is a global static variable, so it's the same
> blocker (address) added each time, maybe add_blocker() should do a
> check to avoid duplicates.

Maybe we could do something like this (I have not tested it) but perhaps =
outside the scope of this change set:

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..7d85821315 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1696,8 +1696,11 @@ static int add_blockers(Error **reasonp, unsigned =
modes, Error **errp)
 {
     for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
-            migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
-                                                       *reasonp);
+            if (g_slist_index(migration_blockers[mode],
+                                 *reasonp) =3D=3D -1) {
+                migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
+                                                           *reasonp);
+            }
         }
     }
     return 0;


>=20
> * Otherwise it looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>=20
> Thank you.
> ---
>  - Prasad
>=20


