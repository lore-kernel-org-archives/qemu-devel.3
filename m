Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C79EDF053
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRqt-0000Ns-83; Thu, 12 Feb 2026 03:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqRqr-0000MA-Dc
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqRqo-0001q6-UE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770884101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CB0PMT4NRuvpGKKz3avwzSPLWaKso1o681RmSvGxl7M=;
 b=WRM4TMqWo2hoISrlbJ/1Pp8OIAcHCkc1KLp6GZu63nEfk7b6p2CTyiAUCVDNBfM14yvGj8
 i3SMNia7LQ+C/9IvGslbd+88szqZ9BYFbacxhuCNEdOWFLUKtTZExMluRfEKhf6hgKRsTk
 5SAa7y4U9hjPvjMp6O5RCEY9nsaPfgA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-CL0CJvtNOHaDYztP_ObPaQ-1; Thu, 12 Feb 2026 03:14:59 -0500
X-MC-Unique: CL0CJvtNOHaDYztP_ObPaQ-1
X-Mimecast-MFC-AGG-ID: CL0CJvtNOHaDYztP_ObPaQ_1770884099
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a7b7f04a11so82543675ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770884098; x=1771488898; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB0PMT4NRuvpGKKz3avwzSPLWaKso1o681RmSvGxl7M=;
 b=Y7V5TMwDfi52bRuF4eBM1C3w2m8vzZlqpdT9JPfS1HD8+gIE/C26B8TbvERD1/s1Ys
 r0CxtDRbtJOC/mXtWyahymAJQnmO/MFs4gkG2WWCA/AuBcX/1QmPbA7hbr3TrFxFfbsF
 Vevu/2MccrcMv+Izi5wp/qLTGPMAH9fEpLPstregtbGcMzL8S8UMP0mtboqMV0CoaO/P
 QZut4QcHf1TBOxbuf0mmbjXlcb7gQp9quZQDK0rTC7ae2PrixU6GmE8Aw+HZjwRcBuui
 yPF1Rf5vcq8YRy1RenA7kZ3390exkIlC+/OkECS7UA1PJ4Zk0NFZ+15INgq+7CW0emO5
 DLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770884098; x=1771488898;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CB0PMT4NRuvpGKKz3avwzSPLWaKso1o681RmSvGxl7M=;
 b=nniw2/M5tNrzXvnb9WR0FMDZfzIIdCUIVBcnqhsItgIdTVXkpb0OjSoawKwwInJVf+
 g7C4rlu+3dGfZ4Z3VWsnTCH19ayf1C8ZbCbDV3de0L7ceney1NdzitrSNqDm3oeLy8Ge
 b4EC4QqgsZfEvyK+g2FAAWBI/gQ0kgd+oaYd0HjPFvjTmPeubHEdRuPDXChaBy+e7Y7a
 1cYoDPsxM2ASrjqk/w3uWD36vo9sJaKTKqqTMr+lGd+kilOObA+knlQtzN3YLbj0FiM5
 iK0yFAfY0V1KWIl24qpEsMQv709SoBP9ilAAplq6OsumtY1sEKGFz4H2V7Rz6G5Ve9Ld
 W/SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+DVK1ooE1DnuJ7s/elBlB2svu8oXdwo3VGa8/LNjjRX1wYWEBi5yEvbyN/LCsIeZn5J0CDRDF+7O5@nongnu.org
X-Gm-Message-State: AOJu0YyzvU356p5HsOT5AYvalSSY9FpCux6CT0fBXY+9C+iDDFB22SdE
 N8VKunE2pICavH4V9Jv38fP2B7vKHCg4n4vRcLiklbXbDFBY7oHDogV5OqygpjP7D1eiUka8E/H
 1e5s/YvHC0xr4cgdpRuwsUxfjep85/SjAGlKp7COCcAHREFP1qKqPta70
X-Gm-Gg: AZuq6aLnD1eS8Pdf7Yw0feRUnoQKL2tXKqIKKXvuOTruhLPVzreqk167lqDuF2f0pe1
 u39R1O4KQNYC4/Vcu2FjTWPDmsrW1enrxCjZ1eU6ZSsb6ouzHLQ+NdwCVUG718bMau3GWbzpfqr
 9e8RNZDE2tdjZx5KbAR4jSD+6LzhRPQTG7dpSvFEg2X3+40BdGYbhl4fsIf7vf6cvnQ2XguNY/V
 sVnQHwzT7cxl4GUJb6aItOOPFUh8UxjFDusp+9dWFxybJ38AXNCiw/tKHDiaiAjL62fqhRNA3dD
 tVWMr2aK91EP6C5cz4Y+szbSwS7/UUm3phELeNjW9RWt6uOyCp/w3xN8jtgtLaXnvp1P2pwE7O4
 1Ymvys1bgfi8sUBoUDVDY2mqiI7hqbFDO8ggfO4VCL64yPpBZ85dKsnmhMQUeTmvCTe7w/Q==
X-Received: by 2002:a17:902:d586:b0:2ab:24fa:f7a0 with SMTP id
 d9443c01a7336-2ab3b185785mr17059625ad.11.1770884098648; 
 Thu, 12 Feb 2026 00:14:58 -0800 (PST)
X-Received: by 2002:a17:902:d586:b0:2ab:24fa:f7a0 with SMTP id
 d9443c01a7336-2ab3b185785mr17059415ad.11.1770884098282; 
 Thu, 12 Feb 2026 00:14:58 -0800 (PST)
Received: from smtpclient.apple ([122.164.27.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2984ab2fsm41622275ad.17.2026.02.12.00.14.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:14:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v4 00/31] Introduce support for confidential guest reset
 (x86)
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aY2K_9mEj2oT_I0l@redhat.com>
Date: Thu, 12 Feb 2026 13:44:43 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Graf <graf@amazon.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <820317C2-F452-4985-BC4F-26F7D29B4787@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <aY2K_9mEj2oT_I0l@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
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



> On 12 Feb 2026, at 1:40=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Thu, Feb 12, 2026 at 11:54:44AM +0530, Ani Sinha wrote:
>> This change introduces support for confidential guests
>> (SEV-ES, SEV-SNP and TDX) to reset/reboot just like other =
non-confidential
>> guests. Currently, a reboot intiated from the confidential guest =
results
>> in termination of the QEMU hypervisor as the CPUs are not resettable. =
As the
>> initial state of the guest including private memory is locked and =
encrypted,
>> the contents of that memory will not be accessible post reset. Hence =
a new
>> KVM file descriptor must be opened to create a new confidential VM =
context
>> closing the old one. All KVM VM specific ioctls must be called again. =
New
>> VCPU file descriptors must be created against the new KVM fd and most =
VCPU
>> ioctls must be called again as well.
>>=20
>> This change perfoms closing of the old KVM fd and creating a new one. =
After
>> the new KVM fd is opened, all generic and architecture specific ioctl =
calls
>> are issued again. Notifiers are added to notify subsystems that:
>> - The KVM file fd is about to be changed to state sync-ing from KVM =
to QEMU
>>  should be done if required.
>> - The KVM file fd has changed, so ioctl calls to the new KVM fd has =
to be
>>  performed again.
>> - That new VCPU fds are created so that VCPU ioctl calls must be =
called again
>>  where required.
>>=20
>> Specific subsystems use these notifiers to re-issue ioctl calls where =
required.
>>=20
>> Changes are made to SEV and TDX modules to reinitialize the =
confidential guest
>> state and seal it again. Along the way, some bug fixes are made so =
that some
>> initialization functions can be called again. Some refactoring of =
existing
>> code is done so that both init and reset paths can use them.
>>=20
>> Tested on TDX, SEV-ES and SEV-SNP. Tested on non-coco hardware. =
Tested with Xen
>> emulation enabled.
>=20
> I see no QOM changes here, so is there any way for a mgmt app to
> detect that QEMU is now capable of guest reset with TDX/SEV/SNP,
> compared to the current behaviour ?

The thought did not occur to me. So other than the availability of =
'x-change-vmfd-on-reset=E2=80=99 machine property there is nothing else.


