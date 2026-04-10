Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F969F44869
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBC3y-0002iF-7j; Fri, 10 Apr 2026 09:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wBC3w-0002ff-Ar
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 09:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wBC3u-0005U4-Fz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 09:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775828296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90GlQ02GA+w1eGs62STQFXkrZqT2kakYwYUQM44UiDs=;
 b=JywY8Ak3xxCRkPan40yQy2M/KW0VwuFyWTP0Uy+nc0VDBpnSk4AaNkfFYGjYqV5VuC1PQp
 RLa57wY9F370lUPMb1lw6vLY+kf8imqxawyAmJA7KxQlVDV/mUL3v+Sla69ClIk0t79T6N
 IYPzZ8+oVH92e1bxg4QnG8pEIR+QKG4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-33rI6cm3Ps6XRw68nxIc7g-1; Fri, 10 Apr 2026 09:38:14 -0400
X-MC-Unique: 33rI6cm3Ps6XRw68nxIc7g-1
X-Mimecast-MFC-AGG-ID: 33rI6cm3Ps6XRw68nxIc7g_1775828293
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c613194caso1157242b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775828293; x=1776433093; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90GlQ02GA+w1eGs62STQFXkrZqT2kakYwYUQM44UiDs=;
 b=gWrj96DBjzpye91qK2GCCllHPDhGLqa3yRnLDI0USr3OsJjTdvLc31bqadfdNghWl6
 M66tJaH8DVRpAMm4TOjiKhj9aMRN6rmyAliYJMxBtvM91sOPQXU8ZSYfzE6+D2DWVvmB
 vvntSu5jeemFEd1cZIoIL8BDZNav87WaHMQ0/wJte3bWz1iucRDbr3ot0UPhPvMKXpXZ
 Sb2Jatk+VkvZBd39cZbl+KFa21gsZ/IPsTxURIBVjP8z/5NEnInqKSg+80RuNuTVhMQa
 IM1yW5vbadchgslWjM+XZCo3MgmRIAFL7D/MqkGCQPzoA11F/SFk82bhav0PU7OQuEEQ
 TDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775828293; x=1776433093;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90GlQ02GA+w1eGs62STQFXkrZqT2kakYwYUQM44UiDs=;
 b=dTdJJNQCkuHpAiQlhszuY6osfGAvZj9e69kKm+rtKWw6Jbx7gmIv55z3Q2ElpZPaeU
 Ur5cmhDLs3MNZ3JopSB/vcmP/3uo340kyZPtTLSQYDg+GfaxBeTXQ8/QumnQPky39o3Y
 A0QemRrsaSg//uyzRvBjdhT9xCkx9xTHNf5W1h+ZY3VmPnTPuLYrTIvZ3ej7YOW6qDlt
 dJ6g6x+6SOiFBI+3KiT+xbBUJqqrMCpwhtzQ2iDMb11rrNmIKKNJ8eyEpdeqp53GvkT+
 LYxNOn6bM+JvbWQTVxb+PiEEQjWYXcrhrTXFMCCZj4p14UjsJxc8+9s9fUpFmV1wsazD
 TqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1FhzrBS8NrpV+KxVhgDf85JWcnntgjfgEA6yjWiU6BI3R5byjc/60d5HOSsJuHRd31zUnJEgWV27S@nongnu.org
X-Gm-Message-State: AOJu0YxyUytPn++EcFreRgZzZGTzBruRi7fHrRNJjTxGQoEHqlZU0I+B
 hTJkDCXmUIcfiMaAXJSXr0RLXU7yvC+4l2GoP2IZpj73SDm3djeXXzA5fwDGRZtegC4fAq2jTSV
 o1gjrnHZ32fJdL7/Xor+IBHZHx7jJL04uUQot99UbOAitLIMC6ZzvUe2h
X-Gm-Gg: AeBDiet6pxQntIz53dThZ9+V2pH23CUL3q0zvkQ+LQoLSutDgIgeNqHmqu4pbcG4tjj
 mcfNaX0hRmvu0Q2WJANa2QIwUYPol/0lY/mhq2h0nfkw9fj/Uo9yV+u7U42dLswOsK9O34edvSJ
 /fCDM9fj0YTDX+R50V4p0kZzclQ/UVBoKwaZWNTYCqzVQm6VVCs2Kp6kpcXuo+EQFUv/J4Y5JZO
 2VghfRZxtj02G4l9vaDu/djS4lr4sW86zy7FqAKJ+QQApIE2c9lUFxiTd0+MZlnTBgMPrsbfimN
 PXlQaM/IcqCCNoowT7lw04LG7wVawbbSAT70e9NQRupyTxurWe8dWc+YBYZ3lksJLQUJl1pqby3
 WRw82rb3GlNH5feTRl3dPHTofKMqb4EZNZfefqcie17hmLn09eHIN7SjXyv2mb3SWIxbtfM9kFN
 w=
X-Received: by 2002:a05:6a00:aa85:b0:81f:852b:a925 with SMTP id
 d2e1a72fcca58-82f0c1cc121mr3580974b3a.1.1775828293100; 
 Fri, 10 Apr 2026 06:38:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa85:b0:81f:852b:a925 with SMTP id
 d2e1a72fcca58-82f0c1cc121mr3580943b3a.1.1775828292578; 
 Fri, 10 Apr 2026 06:38:12 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c50d24bsm3858685b3a.57.2026.04.10.06.38.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2026 06:38:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <c49859ce-7d98-04f7-69f8-d241e4148278@eik.bme.hu>
Date: Fri, 10 Apr 2026 19:07:56 +0530
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6816BC33-C3A0-4E89-8F85-C6ECE1108409@redhat.com>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
 <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
 <69167029-AE49-4BB3-9A5C-D16E51E5D40F@redhat.com>
 <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
 <c49859ce-7d98-04f7-69f8-d241e4148278@eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 10 Apr 2026, at 6:34=E2=80=AFPM, BALATON Zoltan =
<balaton@eik.bme.hu> wrote:
>=20
> On Fri, 10 Apr 2026, Harsh Prateek Bora wrote:
>>>>>> The lock imbalance:
>>>>>> When kvm_arch_process_async_events() returns true, the function =
returns EXCP_HLT before the bql_unlock() call.
>>>>> Why should it unlock it before returning? In fact it=E2=80=99s =
opposite. If the function had unlocked bql, it should lock it again =
before returning.
>>>>>> This means the early return path keeps the BQL held,
>>>>> This would be the correct thing to do.
>>>>>> while the normal execution path releases and re-acquires it.
>>>>> Because the functions it calls after unlocking requires bql to be =
unlocked. Since it had to unlock it, it locks it again before returning.
>>>> It had to unlock it for the same reason - to give others a chance =
to lock. We need to handle failure/exception cases for the same purpose =
as well.
>>> But by unlocking and returning you are breaking the semantics of the =
function and introducing imbalance.
>>=20
>> I think it is better to unlock bql early in failure cases.
>> Even Otherwise, it would become a bql_unlock followed by a bql_lock =
in the caller for EXCP_HLT, which might look a bit odd as well.
>=20
> So why not do
>=20
> bql_unlock()
> /* comment explaining why this is needed */
> bql_lock()
> return EXCP_HLT;

If we go down this path, what would be wrong with

bql_unlock()
sleep(100);
bql_lock();

This would make the window even larger for the other thread to make =
progress =E2=80=A6 How about sleeping for 1 min? 10 min?=20


>=20
> That should keep the function return locked and fix the problem =
without having to hack the caller for this case.
>=20
> On Fri, 10 Apr 2026, Ani Sinha wrote:
>> >>> I did explain the race condition observed above.
>> >> So why not fix it properly?
>> > > I think the suggested fix is appropriate for this scenario.
>> > Keeping BQL held forever in a loop for EXCP_HLT case isnt the right =
thing to do.
>> IMHO that loop is a symptom of a deeper architectural issue. The fix =
proposed here feels more like a incorrect hack.
>=20
> Even if this is not a complete fix of an underlying problem but only a =
work around maybe it's safer to do this just before a release than =
trying to rewrite something deeper now.
>=20
> Regards,
> BALATON Zoltan


