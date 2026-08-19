Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8688C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwXxz-0001sq-SA; Wed, 19 Aug 2026 00:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwXxy-0001mC-IM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwXxw-00016R-Sn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787113911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6o0NidL5sdHGm6Q+EpFzykpnKPAcdxN8pc8kloLqTE=;
 b=Us/a6k9FtT4r58xW2agq4u8WuQ4XenylbebHr4Rj1Rm6pRQ0C3QfuNeZ+SVvjL1M2Pdw8r
 5IV7GyS6OLG8T6wcsd+37uyEdQ+AfLmRv3NJ54Gm3k4hj7eXy2/jZmQVL4biw6Hyy1D6BK
 oxkEo0VHBi2xdmboOZ0ozdikqx3BIlo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-fNuHcC10P_a3nj1tRHJK7g-1; Wed, 19 Aug 2026 00:31:46 -0400
X-MC-Unique: fNuHcC10P_a3nj1tRHJK7g-1
X-Mimecast-MFC-AGG-ID: fNuHcC10P_a3nj1tRHJK7g_1787113906
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so1362297a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787113906; x=1787718706; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t6o0NidL5sdHGm6Q+EpFzykpnKPAcdxN8pc8kloLqTE=;
 b=TUUlVzsCEyKFwRS3QyM2SggwF52NbFHrMeclKbEJsBAn01MOuCR+37oYX4prSWoSSA
 reB0zY9BKYzIkEQneBGGAY7ZD2PxSXkVTUGjCduzMePz8rcFtNV5XrW1gBptXKuR8RSd
 TWyuhTKKpdvAuU9VDciK9ezf2BDm83WBIzlZOTx7TGiJhcqm+iBdcaK4Sqvn/YyzPSB0
 DXMpHGuP4pc5CyRmR34MgsoQoRQN3gIGGBrahaokZz2WuBSkQ82GGK0IXUwpP5+quhYs
 i44Elq8DwC1+vVfu3kP57VTEBsHh4mx12YaPPFwIM8+Iy5Qg3LtqqHPl4zTOzIwA0Qsf
 teqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787113906; x=1787718706;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t6o0NidL5sdHGm6Q+EpFzykpnKPAcdxN8pc8kloLqTE=;
 b=dn2YPjj9+rl/22jAmiGuhfDuWVoIvo9n9zVhHFHp8oUM8x548jyrMwI8oaHKbcAyW/
 TOXk9y1oE9ILipNh3oe8NP4qHCtQd8rbcW7M+nwUQLZmbKoAkJDxfJ0siKxdeLl+zGjI
 FDi+2uPNkddKPIoLYFwup01Nk2ZMjGrTyp1XPfDiIBs2+v/sD9ecIkyNOXmNrU11O22a
 mdJTzxyfIIgngWref0s3q6cNddwSdwxFS3WpHbN4EQckEbRvwsx40WH+lPqp78gmFf41
 7Hgv8+VeVbqBPqR37PdFW5VkX24FTQfwdHmIUJ9wI+24QjBK8Xy78d71QGh4J6kLNjxO
 relg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3i8j79HDzLQ2nwQ9aluBigMCb68Zkx8YwMY1JrNoeOk5F5hemeVnS2oHDy0De7qiCMf5NGo5dCT0O@nongnu.org
X-Gm-Message-State: AOJu0YwyEnYqyp3fp7fjUG5xgcvmpFjcpcBn8Cpl7/JN2dHHpwZUtkkC
 4QSo65qRmUr1Ggk+Gx35FGBNqvjUZs39qjwlHtUR06SMojd/jQTKHwNkFhLKgsPxSTb+wl6lcGQ
 FvTz5RdCTeOS0HaSSmj7hiX3u4AEo775ni+OMk8usASacjtFrlGfhm8Gc
X-Gm-Gg: AR+sD11Sy6lSt7Trn4gTGppxib02Jvj+/BiNCaZj+WrF/qVjM3PW+RthjIu9c18EynZ
 s41wf5OLrYFwbmZkXnbVzKYPIRijTb3XCV1xYHAfTkKS6J8YEx+JruT/g2fJJVgDCl+SDeGPquj
 /PZKOfuku8bxn8ljKtQgVtYqbBSggW+yEWWvxFdOAMlc88Pc3KYgsfEjs+kqCv7iNXNkDN0DK7a
 1QADU1jVLAEKjy9wTmQvqDyR9q6uI6bgW7eAG6WewIABfAxhpJGGTyUVFasSxCFZ50De7jE9xfk
 XqYMhS+nFXpk1V4aIYJAiXLjohGyyve6kf9H8E6peAvJDS7o5CV518AH+qTallPe55IhksFoYxf
 GY/1LyVC4skaUDwaBMgOxg2Lctf0cL+iC53C/jYsdNE6BusH74+k/SQ==
X-Received: by 2002:a17:90b:5385:b0:38f:caa2:5721 with SMTP id
 98e67ed59e1d1-395812a8662mr3667271a91.17.1787113905571; 
 Tue, 18 Aug 2026 21:31:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5385:b0:38f:caa2:5721 with SMTP id
 98e67ed59e1d1-395812a8662mr3667205a91.17.1787113905157; 
 Tue, 18 Aug 2026 21:31:45 -0700 (PDT)
Received: from smtpclient.apple ([106.219.133.98])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf15ff5dsm2173293eec.25.2026.08.18.21.31.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Aug 2026 21:31:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v6 06/11] hw/misc/vmlaunchupdate: add api header
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aoQj6adCq0pnmhiH@sirius.home.kraxel.org>
Date: Wed, 19 Aug 2026 10:01:29 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 agraf@csgraf.de, Alexander Graf <graf@amazon.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <120B0AD1-ADC0-42AE-914D-01FA6CD3C14A@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
 <20260817142010.80693-7-anisinha@redhat.com>
 <aoQj6adCq0pnmhiH@sirius.home.kraxel.org>
To: Gerd Hoffman <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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



> On 18 Aug 2026, at 2:52=E2=80=AFPM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>> +/* status code */
>> +enum VMLaunchUpdateStatus {
>> +    VM_LAUNCHUPDATE_SUCCESS,
>> +    VM_LAUNCHUPDATE_LOAD_FAIL,
>> +    VM_LAUNCHUPDATE_NOT_IGVM_INIT,
>> +};
>=20
> As this is an external API it should have the numbers explicitly =
assigned.

Sent an update here =
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg04166.html=20=


