Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE565FDEE25
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwr3-00019N-OY; Thu, 23 Apr 2026 12:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFwr2-000195-2p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFwqy-0000dH-UM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776961475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urIdTEjp8Pz3DgpIIviOD4Bt6Lc7e93jRHjJdHB+ydU=;
 b=HhufaN/UhmdRBmty2R7N7X7kI5Ub1XDraDcBpXdYhId9Us6NO0cOUbtHVgPl1kebDFSG6T
 svx23lf54h1AwHjNykL23qVPlIHRCt2Z+f0ZsdVgsTDvoFGHjdW7mr961D1mulYd7deHRH
 vWtf8pKLPT7p+bOjje45KtomXto8Wag=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-vLKq7iFLOSKQ5QupTO6JRA-1; Thu, 23 Apr 2026 12:24:33 -0400
X-MC-Unique: vLKq7iFLOSKQ5QupTO6JRA-1
X-Mimecast-MFC-AGG-ID: vLKq7iFLOSKQ5QupTO6JRA_1776961472
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-440d0d7872aso4102814f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776961472; cv=none;
 d=google.com; s=arc-20240605;
 b=RHu6YniFksUjK/RYG7RHufyn4+Aepnu5RC/P1NCCO9D2fh6j6yc12tU0pP1O0xkfXR
 KPQgPQ8qMNwDcvvMdI1/pvQiluNA09OZAQ8uxl3TqI483As7X8xgJIJDS2HNfiSr9Tw1
 Wbw/znun6uu40ykKYMvkgAJ81rHZYWPLg5qq7JMn0qeLD7WR7xy3awcDK9OICb4sJFIS
 kLeFyEDwpJ0lcitZ9V5DA+J5yX/oyuroACBqmcVwzWKR/mscPtR81L5P84LaqLBxtj71
 Vwbyqr800YBn/AQ1r59h3GS5fSxa/QuOYJO2MKpVaAT4j+G/UpTmVQiaAc/zkCSkR9Nu
 wXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=urIdTEjp8Pz3DgpIIviOD4Bt6Lc7e93jRHjJdHB+ydU=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=IRSU4WCX6QjQToWUpa+PvcH1G1ZlnDxAjp7maBw3q6RhEawsjx9QRhNmBb6wF3Kh47
 tLlmSPHjhr1UfbUlmek8J3FpfMXjCBB6Co0PKxgilEPBCliO0Qm/SuEZGKwoYNjUVtlb
 qUHFnuxWcTWx+U9OLZZwSakgcHcSZKDFpheGyDpO8Sz0iR3Wn4XvM9+Td9uJFIcQS/Di
 yX/CnBK3cr/lwhHNko4KxQGvbUf8yii5gfKdyZeuJvMwQ/+5e6fVJvRJBkAxAqlGlhaM
 9vQFssf5gtKd68n/l6trz9wUr2FAQcACW1ifFRI0IimEnoFtjmBAexGTqzJOJJTaVSk0
 LmqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776961472; x=1777566272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urIdTEjp8Pz3DgpIIviOD4Bt6Lc7e93jRHjJdHB+ydU=;
 b=VQ10yTJ4gRpJVLlMRTsM9fI1ceg4P5nCucZKuD7pzKP2WkBt/AYwv43PKKoz+s8xOE
 CTAwThrPdbyAioYy0CCMon8oTWU1h0fqAe14T1luG9gDalcTrIgBWZmenV4zzLANl/YS
 SwjNBMtuzl8bY2xaAh7RERycTpcoXC+o7kGGkDD6RDTFEiFr+g2w+sXaCh4QNucTohDd
 2fHu1exiETby9PEGz8jsbpTXGgfjE2Kps8IYX3qmHSu0jXCfZs5o9Tqdqv7CzBpfmj9p
 WrJ9qZn7NwVPeWPI3QCLYkeLUD8dJZLAHLYaP6KseZg9WmJC1Z6+1NuUygECgbDtnvAs
 /5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776961472; x=1777566272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=urIdTEjp8Pz3DgpIIviOD4Bt6Lc7e93jRHjJdHB+ydU=;
 b=kuY/CDuxeVPRJXjwi4eOdj04H+QkzmzWkxxgnX3uPlprH/Y9nNx0ZS4bTtW9AtIDHY
 +LkMz3YGOFMQPk+8I4Y/UUUdYXy8hhSmkIDHdr3jO29rnOrK1RD0qi0oTui0Pr6dwWiu
 ap9fsx+S8W6qzy58LFVa0tNQ4hxR9VYmr22jfDk560MqtI7159EHvY35KMCjdMv0hkdR
 k8A8Y8X6eAm/TMPSpsiC25BrlK/GQzguN3aJT0aDQ3kXRNb727nR9qmIUHNvHIUiUuP7
 LcXGn3GlLzqWd7A4HXz80FQApFuvLtLSBB6Pfy+a/kdsYoYbbiQhosRN8P7LMYOXAuzT
 E/Ng==
X-Gm-Message-State: AOJu0YyjQWTcJx9gwSQIn442rGFBHA+/9jfpGABKmOoZ7IsivTEoHcvs
 0dd3COkVwlBIrQTzlqN8iIPVaEvC1XcUDgoYbyIRA1e95BJpBn/vJRpAntE5A8RzIaGs7qnLOPj
 9mvHsiHoc+6nFzXsSgOlakJXAukbJZC6BUr84EavaptMiXSvYVh/zGtX4jYdjZi9v/5KA3n+3MO
 8tn14505tvWIFowGK1B2aSK0FHEb9wv7w=
X-Gm-Gg: AeBDietrkh0NkEIw6g0uCwgrtN2Ax4aSL+kv49PTC0yy8EYuVJ4EmvanwfPwtaYG4YE
 L69CDXKSNWvY95SKEd8U44ETG//w3atCOGkwJVPlMA3YqA7MFcpfuxNVwNwO8YreWPOyfehk+BS
 klhy04Yyp7a42GyJAcoIFwHmm+ypGQAWBABbwoqliw8gYTFHL6r0RRTKy+0VXKy0m8DDtV47m2s
 SaxDn5/oTlCO8S7DP4ER1yt1cwFi/UzJi5lUIZWTswsmobKcSBjYgtGuxHEUAl6Zaipd+T2avTQ
 dFwnO/ID80neH8w=
X-Received: by 2002:a5d:6481:0:b0:43f:e42d:92d with SMTP id
 ffacd0b85a97d-43fe42d0a21mr29159719f8f.4.1776961471816; 
 Thu, 23 Apr 2026 09:24:31 -0700 (PDT)
X-Received: by 2002:a5d:6481:0:b0:43f:e42d:92d with SMTP id
 ffacd0b85a97d-43fe42d0a21mr29159695f8f.4.1776961471396; Thu, 23 Apr 2026
 09:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260331095950.512326-1-pbonzini@redhat.com>
 <87cxzqrwqt.fsf@pond.sub.org>
In-Reply-To: <87cxzqrwqt.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Apr 2026 18:24:19 +0200
X-Gm-Features: AQROBzBN0Wb2DTJMmx96sZ3-P2Bu_HH0VT7wM5DQYZhpwR6katrg9_VzemaG7F0
Message-ID: <CABgObfa954MMVPH==coTOAFxt_dHUvSiDDVHFPnA3aTL6L8F1Q@mail.gmail.com>
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23, 2026 at 8:56=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
> > +    } else {
> > +        qobject_unref(r->result);
>
> Unexpected calls to parse_emit() won't be detected as long as the last
> one yields the expected expression.  Worth detecting?  I'm not quite
> sure.  As far as I can tell, this is not reached at the moment.

It's only covered in /errors/multiple_values of tests/unit/check-qson.c, ye=
s.

> The stupidest way to detect is to assert r->result is still null.

I'm all for simplicity.

> Can't do that if we want to cover parsing multiple JSON expressions in
> sequence.  Collect all the results in an array?

Yes, but not now. For now the assert will do.

Paolo


