Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA8CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNEp-0006ww-1k; Wed, 24 Jun 2026 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcNEn-0006wA-U5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcNEm-0000fN-7o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782306110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHJ1rOwbIA72gkH2eQ2L5h6O9Oy3A0Mj05wz7AUfmjs=;
 b=JifCpK2ej34a6UIqhdZ7CUHng5UJ/ep3PraNfHBVea1Vmjmc7ht+HT94jheyLJh9w6jSVg
 mhGtIpU571WmXzIt29AXjAoRA/+8hEqU/HQm6kYyuX14j5vzaKl51LO+GZRpy+gBzxFovF
 ZfonGZvCTp1b1BpOtpFqjQt2JkJ3e3Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-nd94CwOtPbq21tgWZsyqsg-1; Wed, 24 Jun 2026 09:01:49 -0400
X-MC-Unique: nd94CwOtPbq21tgWZsyqsg-1
X-Mimecast-MFC-AGG-ID: nd94CwOtPbq21tgWZsyqsg_1782306108
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7ef28ce24so2274055ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782306108; x=1782910908; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHJ1rOwbIA72gkH2eQ2L5h6O9Oy3A0Mj05wz7AUfmjs=;
 b=Ej+QS5xI+j9aZqQnOTeQ8q070zY1njyZtXyjUiy7AAOm78wEXIJ/ld3+AGH2Ogemdf
 7SXGUhJNiQzt1cFeXiKNaK4Eo6Bq5u6iCfx8RsbPEE5Vnr63LCS7tEvV1nGCuzA5C/Ej
 IyqsqnYAchqtf7VX3Low62YZyk8mxiysrkfNOdFugbYukiWfj4To0bNXisnthto5dxsQ
 dJxdT57A/rd6b65kfLLeQfd/9rxL9f7BCwUsilqkxlCPZ8hL8Qim6saGusM595KTvEzd
 aDUlHSii58VqZ6S7nQcM0wHlEhfSi7CGhBaLkJXESylQx40rfXHIaC6lk0CLG9LFQZW7
 RAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306108; x=1782910908;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHJ1rOwbIA72gkH2eQ2L5h6O9Oy3A0Mj05wz7AUfmjs=;
 b=owvEFmNf1BpkqbVtiSseR11vbpS4tqJUGiRXq7syRURwAF6TEedsgGDLIa+IohFg90
 BK9gwCJMSk9jY4KVq391zPUSmQsS/RXHgOOZWDVHtz40kf57qGgSRJgX7nDJShAz83H1
 AUFuwjCxc6zVI1ARkLqK7q4A3GBaxpkuhjuzAALyAqs09enp/6uw/GHaDuPkzgPzoN0k
 zPin5Yk9CWr1PYz4e1xk3V+6t5fpTEH6Dkp/Z8UiKcy1yOeVA6xw8clhljuhR0QHg3BF
 fhI1nRcrj9sqrrjXzmaFSwMxZZ0osNQO+/qKI3HpIPfbrQMUkoEi+1DpVZ+NLhObiwv+
 mt2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLchPJBhD954r64N9BxpKDqmFYAphLI4IqL80C6yyDI0kglqjn7own8N7hnTfliINAmAIxnJIsrlkd@nongnu.org
X-Gm-Message-State: AOJu0YyxvTtcfXitdgR+IUn6tJMWjZeyNC6A2Y0w+nsQEylt5ptJqG2t
 xquv5315/GMJoGrfsKQuu0cOGPGVEN2Yw2DleOfPAuaeqSnCC2m0o2Xpy+hiBr5y+3SiKvkzVSE
 kQMMdK18pLFspS8hPk6QZ37Y1D5phLxFWIEnYVPfVNbj9HyJHI8TcYlbPR0gFpD7B
X-Gm-Gg: AfdE7ckKx1i12SR1PRlx64FFW/m+SpPw+pZSTMBEMpYLdB5dy4jfONItl79+5lBam1K
 8gO1f+d+rdk7MkZH2a9DQKgXtRy7MnMHf4Cjjrzs3juG3CH3+E+qbBjKE4eGemwq7bUOw30/sis
 5GaTEHqtqEPZbh5VdmdhT+iHaup3DcrfTTCgVKqGaM3dj4fA61eIGicf+dUPoR1iSIh0SrYEhoo
 tS0wgdr3irpnvnbzZl7OYrFTVpDEGnPHYNZm0cJo07ZhnawRgrmk7Bf3JhR+VHTQUgmLsXNy4wI
 LCVy8Mjk/EjLp7XJbxsZQk3yxU1ofusNKKTgGI1PLMhdttqUSupk1RHfklFHupGJN9/A3h5fENP
 jJa2aZM744e+Zdjd6zNY0bEkSNmgJ66i7geE/VIucnw9IFFsCnbsBOYM7cXn04Baw
X-Received: by 2002:a17:903:4b27:b0:2c6:e146:79ac with SMTP id
 d9443c01a7336-2c7c7592b72mr77844965ad.7.1782306107843; 
 Wed, 24 Jun 2026 06:01:47 -0700 (PDT)
X-Received: by 2002:a17:903:4b27:b0:2c6:e146:79ac with SMTP id
 d9443c01a7336-2c7c7592b72mr77844025ad.7.1782306106872; 
 Wed, 24 Jun 2026 06:01:46 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436af22bsm130162515ad.10.2026.06.24.06.01.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2026 06:01:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ajvDMzTGk91aJl9d@sirius.home.kraxel.org>
Date: Wed, 24 Jun 2026 18:31:31 +0530
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alex Graf <graf@amazon.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <129574FC-96A4-4E0C-81E8-338E68DD3675@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
 <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
 <602FAB73-36A1-41A0-97AA-7541102F23A4@redhat.com>
 <ajvDMzTGk91aJl9d@sirius.home.kraxel.org>
To: Gerd Hoffman <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 24 Jun 2026, at 5:32=E2=80=AFPM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>>> I'm wondering whenever we should better keep the original file, so =
we
>>> have the option to switch back.
>>>=20
>>> With a boot workflow like this ...
>>>=20
>>> (1) boot qemu firmware
>>> (2) some efi app loads igvm with guest firmware + kernel
>>> (3) reset
>>> (4) boot guest-supplied firmware
>>> (5) guest-supplied firmware boots into the bundled kernel
>>>     (without even looking at the ESP).
>>>=20
>>> ... you are now in a situation where the guest can't load a =
different
>>> IGVM file (say with an updated kernel) using the same workflow.
>>=20
>> Why? Why would the fw-cfg interface not be used again to reset to a =
new IGVM that loads a new kernel?
>=20
> The guest has no access to the qemu firmware so resetting to that (to
> get the process start at (1) again) is not so easy.  Certainly harder
> for the guest that for qemu doing it (or offer the option to do it via
> some control bit).
>=20
> The other option would be to have some linux driver for this allowing
> linux tools (instead of an efi app or bootloader) loading a new igvm
> file on kernel package updates.  Implies we'll need two different ways
> to load IGVM files.  I'd much prefer not doing that.
>=20
>>>> +++ b/include/hw/misc/vmlaunchupdate.h
>>>=20
>>> I think it makes sense to have two include files, one for the API =
and
>>> one for the qemu internals.
>>=20
>> Where would you put the api header file?
>=20
> standard-headers/misc/ looks good to me.

Hmm, checkpatch is not happy

ERROR: headers imported from Linux should be self-contained in a patch =
with no other changes
#89: FILE: include/standard-headers/misc/vmlaunchupdate.h:1:
+/*


>=20
>>> .. instead of signaling success indirectly by clearing fields.  =
There is
>>> room anyway right after the version field.
>>>=20
>>>> +    uint64_t fw_image_addr;
>>>> +    uint32_t fw_image_size;
>>>=20
>>> uint64_t?
>>=20
>> I would leave this as 32 bits. 64 bit idvm file size is too big, no?
>=20
> With u32 we'll get 4 bytes padding, so we do not safe any space in the
> struct.  Also initrds can be quite big, the standard anaconda install
> initrd for fedora 44 is 252M, this is not *that* far away from 32bit
> max.  Also you never know what people do once they have the =
opportunity.
> It certainly is possible to build igvm files loading your complete
> multi-gigabyte workload into memory, verified by launch measurement,
> then run it without ever accessing disk storage.
>=20
> take care,
>  Gerd



