Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD007C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6A07-0008WS-VG; Mon, 14 Sep 2026 12:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x69zr-0008Uz-E3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x69zp-00060H-4i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789405051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csJqiF6iCPyAxB6OseXFVOlApc2lK/tkfzaPxXPAMn8=;
 b=EjFb+9Rq1AyzWMtAKgl2Ffh4k4favOhXk9QlWjwKH+1SjYT6kAnFV+5Totjjq7st3t/qkz
 XMsPh//9h3MD1bZ6WankC+0rSKLzg9CkN6GxnipHFK8jBkBVsCIylVytneldvalGViVVaW
 0yK4meqazUYeIPNpIolPwRoVtbvSwdI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-g1ma28zKOZ-_HJhGsn1Vrw-1; Mon, 14 Sep 2026 12:57:30 -0400
X-MC-Unique: g1ma28zKOZ-_HJhGsn1Vrw-1
X-Mimecast-MFC-AGG-ID: g1ma28zKOZ-_HJhGsn1Vrw_1789405049
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so15299395e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789405049; cv=none;
 d=google.com; s=arc-20260327;
 b=I6EIjZPuoZXaqLUR/F9fHu5sgkHQP7GL3zGOiEyDuhxnxwvEM1EmDNckQ71gA1Itey
 dkHtKZcpJWNctno4T8om2ENqSoYeY4Z3aj5tMUsMl1o8Q0hKWz8QWwkWnvaIYQbNFteF
 HUBRJ8FZii8RaRekEopoFShuz463KCL6CfTCexxCBOfNAl9Gu/4N1UE/eyhY3YcvhMyT
 zKsuK+AfTM46oVzYlbPf1EcRWKlHclvILj9zUzF/nzZN8rmFucqeo/AZXIzF3uBgTa9I
 ZG45h+7unNk8zOIHO3Eh+p28DeZef2/O56X7+IGk8pCUFpb/OIgXNHfeRHfARVHiIoIU
 IDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=csJqiF6iCPyAxB6OseXFVOlApc2lK/tkfzaPxXPAMn8=;
 fh=iOO5DGIw+RMgVJLlsg9Pz07H7nI+8Mi2vK+KLhPIETs=;
 b=ZVwdJpcglJXBLe7v4tRZ2kgirScclfsF26pY5no4Dmt8Nn2IVEVxUJabt+BETp3fdY
 NF7Yn5tkfu9gtgn9cuFhjtwWGFmc1wGJ7wYjMfShjRnaA/MoYpbYfT5HgHrK3z7uodVB
 Ty9670ST0Xp0GFyZL9EjhhupOFsL+Jp7atr3tpw38k5gfL86G1AKryJyKR6kw36HIqUS
 C+gqUquBFdZnsjUUZxZ09y1OTKx5h/WCc78N5uxJFo0EWZrOZmgJ6LgbJJBRRD7wrU8e
 1cya+dQN0bT5BAgjYZ2Aed56EeB+pyNr8k1lQJmPpsLO3eJUif4Lq8KCWSdVToGX8k7M
 xaPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789405049; x=1790009849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=csJqiF6iCPyAxB6OseXFVOlApc2lK/tkfzaPxXPAMn8=;
 b=CXgwPUwOVxP4Z27Y1C1XXLAD+Q50F5knWEWxyFL7he7/2EJ37tKPY2JIReBR4Ub9FA
 fN2YiZBGF+z7OIseGj4duBpwXOqGS2foP6bJgwMho7OEXXu8JAigZ7TGJHzmmp+jez3x
 AOwetB9xKJFvrICP3rdYcVNEIDlNSuEd7B+r+LJs7tM3HIoYu4AWkfU+sRu1UpNYqTC/
 MqrLVHTSntLkpOO8ww+xL1WQ7haYrBdLpcP+A9W2K9h0eYRegdANRQNjPIyR14900Kwc
 kkCWPQZX/o6+xvz1rf+BbcE7SjP0iR/QzhB+APAJbNyNoRADmWlOLTcOAu+asoRglJQq
 RMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789405049; x=1790009849;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csJqiF6iCPyAxB6OseXFVOlApc2lK/tkfzaPxXPAMn8=;
 b=dST0uI9ioemtdkHHk/5lUuwdjSCJAfpG/kxeJXIfwi2kUZidrd8zx8jv7LSLgitWQC
 C8mIDjiNw4e5MGRgg1qGqozpOUH3fq6VDoYI73playy0EDQcMW9pMc49yT5k7ky6biTl
 UBbjfv5BRQy6hrKaqqc0U01kigJgjnzKxyZzhTFvc3GjiYLJdU4NY6u1JeckbqP7s7gT
 ywA0a5pz9G0J2/JOThk33KWxfk/mm+O7jq/EI2t0AvTFqkxrRHON5NF6m7jXiCe4B1CV
 yT900KlDhw0N50jR6GGZI+7boW3dJE8VM+bAn8hdSfsAUjUzMTpTxjhs6778ra8yUrwV
 q5kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+19hCeThz8p2SSIe84mZH5+75yPRRgABcJDpE2UybUPPmdEL4V5y4cSekwNr61EKtS1mGpSPIUdRS@nongnu.org
X-Gm-Message-State: AFuF++loHGtZ36NqcY7XvmVQQj8OEUZCKKwUid/V5QLU442/w2titD9l
 h57R4QyytFMgIUU2MushrwJHBVePkKe79DDhPyAncdKOyRS/w/3qNxvbSqY6jbXutf9C37kP5Nt
 /3wyr2bB9GEV4N4YxjA352Dx0g8+eR+HL98kaJeFZHhRWqtYF2BmasGQO5wlrFv5m/oDg380m8n
 QaZoQlWCuUD/Js7kxxMBACn8JtREFELao=
X-Gm-Gg: AYBFou0PNfbDWHK8rfPisOcp1OXE6l/W0SW2HJ3uf6QcX5NBFVKW4eiXgbR7W+d7FQT
 4sshhJa7duvb5qrOlSbw7sPfsHOMImqe+cnV3mEh5a6yJIo7WZuuVWSuvE+LXu4RN+fTjASRyGH
 fnpsflGn4fDJWt8dtQX0UWvSbi8cQqXMmLjEA+eQbEs3uAke8sjAkiHM0KAi+aWJ079SjJEaJBw
 HPWejphAY/YhSpC90VSISUH94xHn5+u4X+kbwxVB+OPamU6ym04nnVJxqTP8Q==
X-Received: by 2002:a05:6000:491e:b0:487:198:8fd2 with SMTP id
 ffacd0b85a97d-48702b4d14amr3907667f8f.39.1789405048887; 
 Mon, 14 Sep 2026 09:57:28 -0700 (PDT)
X-Received: by 2002:a05:6000:491e:b0:487:198:8fd2 with SMTP id
 ffacd0b85a97d-48702b4d14amr3907628f8f.39.1789405048481; Mon, 14 Sep 2026
 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
In-Reply-To: <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2026 18:57:16 +0200
X-Gm-Features: AcwNN1WNwDTPk6TIifcsWqACaAFCjDD8JBTcvtucv-5-P9hLb72vo1FtSeVeLaw
Message-ID: <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Aniket Sahu <asahu1x@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, Joshua Daley <jdaley@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 6:13=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> There might be some confusion with what the series introduced. To make
> it clear, it does not touch, nor use tests/docker/Makefile.include.
>
> Each tests/tcg/arch declares which container it depends on, and we have
> tests/tcg/meson.build that automatically builds it if needed for tests.
> Reverting that will not be very easy to be honest, as it's a core part
> of the new logic.

If it is core, why is it patches 102...105?

>  > IMHO it would be nice to replace tests/docker/Makefile.include with
> > a meson.build too. Yes, that would make it rely on a configured
> > build tree, but IMHO that's an acceptable tradeoff to get more
> > stuff into meson natively.
>
> That's easy, and would allow us to get rid of
> tests/docker/Makefile.include completely, by adding matching targets
> make container-image-debian-*. Also, we can have a top target
> 'container-images'. With this, people can build them with ninja or make.
>
> As Daniel mentioned, the trade off is to run configure first, and I feel
> it's quite acceptable. What do you think Paolo?

The problem is that right now firmware builds are broken, because all
the supporting code in configure was removed. I'll review anything
that fixes it, even moving firmware builds to meson custom_targets
even though it seems quite intrusive.

Paolo


