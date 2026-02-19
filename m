Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC02E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt05j-0001Zp-Ga; Thu, 19 Feb 2026 04:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt05i-0001Zh-9T
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt05g-0005B1-M3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771492374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnbmLaX+muEJFDc2ShQ4xB6f0qOb1zbRXm6geKgusZU=;
 b=AkpLWBigY5X+VTPXYem2Rowdnpaf4KU+D+OdXOxtHiRFFuDfcCbhEGpWHlE3qMFlj8s8Uj
 7I8ZDti+XJaIShc1zSSgtECJG5OJFTrMa6euwma3O/mj0pmguu6WxVt9dNUNNLGNkME9hz
 6rCsoMmtIg1l9EMkD1wWrkwlQTAVO3s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-_2Tz4MmfPRWFJCEvWFlmNw-1; Thu, 19 Feb 2026 04:12:53 -0500
X-MC-Unique: _2Tz4MmfPRWFJCEvWFlmNw-1
X-Mimecast-MFC-AGG-ID: _2Tz4MmfPRWFJCEvWFlmNw_1771492372
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c61dee98720so451377a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771492372; x=1772097172; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnbmLaX+muEJFDc2ShQ4xB6f0qOb1zbRXm6geKgusZU=;
 b=H/QNOl03ar3pB1m8yejv92wUT6bNJmjRYt3IRfyKoFEV+AB+V2uc4W0ecQrKqYDs9Y
 NcS+REx/v2WTI/uJSKp6g0d2jlS+fLRT31+dwfKWtiv8Ezu/hmRZDobW3fk2lkRVpjQ6
 wC8o5Qr2lV02q4T4rd71a/uMuM2iI/iRdpVJRCUWkBp/WFWLqYRhzAgu3jX7u6POlVGr
 yqFDORp3/rKhrskX0O5N9sHxhfEULrqM26Ep9yYCYfCMz/20PDczLtvvWenvPTXWVBuv
 1RtX16/RzJwMJmoZTSeW3CdxBo7iTl8z8i6Gcrxoucv1QNbxJHZD5bvJ1P7lAJXXdYk9
 VkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771492372; x=1772097172;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnbmLaX+muEJFDc2ShQ4xB6f0qOb1zbRXm6geKgusZU=;
 b=JS7LrIU/SYeQqY9DEDpgPgtDCtriMZCeBfkEOzLEEhDECfGnIHMzc+Mv2OsoZ/fVO0
 G8QlTcd011odTtuZSlNAhE34DHoj6EwF3Cdz1ht/V8xx9Do4CONr280NCv8qfL/BdXI3
 U3NGe9e2oqD2veVPdGROpkjGZRPFLfek2LUrjz4PwjxSkSUUzAIaf+vru/jhOJ/lUSqO
 nnHlBSiAaabVYpTwPAC5OxLcFuA/SICKyg3BlItqLaQQtIokasKjhhqekkmAHIMOHhJh
 b7bcyUvBylH+GGVjNwl62+PzLWu6oleSzddick2xSQTbpo/I2AIN6jRQZoLnngrCC+dz
 zf1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkmg8la4WiFRkC0BNEa2MkNs+ujOGdEs2gQK+szgMus/61MimJayxrPdtHYXZJFi3V0M3g26CTBgYp@nongnu.org
X-Gm-Message-State: AOJu0Yyz9iuChv3856beckHg7k3JHlJX8UZnWtWxaBbNDLDVSCNHgT09
 or/E+gZceQa4Bvf3MrLvymiOO+2BLkp4HPr6k0QbWUGiUCnYdBi0wZUVh9JmvbCU5RPC3jZ8hg3
 x3+S0SrFEQAefsi6F9Vs3/5GLLj+MqJv9RFVGZWcc5mSTVBxNbmQzCFLk
X-Gm-Gg: AZuq6aK6JQy+bXRYT0Egg2vVl3z24uLhU1N6Iz7PMkm0YeFuSwgJtYvZUcSi+ei7GF7
 RFCUH535p63eNyLWiyFwmSI3RkI7Qg7OfRJSD/L9Y6OzAbgFTz2LoU9J99VFWeTD9sxMNJhXCnf
 LZ1i4Mhe+47vVIHdxRRE3IVTSdtj2yZ52Ei9wKBsbbyXCrqC+F9SzZokFifeyXUqJKdcGaP0GY/
 hwRQtV6j9fmipAnEJ54iq0tOXtZda8EC/TpLXn2ryynrctMQuPTLa5GXLPveZpIBzE6M79btevU
 dgAJiGRx0AwXYUjkZHyZ17BsIsB/VPsm0b3yB5Tl3aBFqKrR66FnwBPhfhU072Tw7VvYqTIog9E
 sbK8/2LYnNB9K7o7iR79MLu0WQZZFzXK04/AH+QqzNh6SMIVgyh5hPhZ7oQCxMNezAkk=
X-Received: by 2002:a05:6a21:398b:b0:366:14b0:4b02 with SMTP id
 adf61e73a8af0-39483a7fe52mr15941898637.62.1771492371896; 
 Thu, 19 Feb 2026 01:12:51 -0800 (PST)
X-Received: by 2002:a05:6a21:398b:b0:366:14b0:4b02 with SMTP id
 adf61e73a8af0-39483a7fe52mr15941877637.62.1771492371542; 
 Thu, 19 Feb 2026 01:12:51 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fcfc08sm15492542a12.1.2026.02.19.01.12.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Feb 2026 01:12:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 33/34] qom: add 'confidential-guest-reset' property for
 x86 confidential vms
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87wm093yer.fsf@pond.sub.org>
Date: Thu, 19 Feb 2026 14:42:36 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECE353A6-A0BC-4A3A-8D80-581CE9150C5D@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-34-anisinha@redhat.com> <87wm093yer.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 19 Feb 2026, at 2:25=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> Through the new 'confidential-guest-reset' property, control plane =
should be
>> able to detect if the hypervisor supports x86 confidential guest =
resets. Older
>> hypervisors that do not support resets will not have this property =
populated.
>=20
> Double-checking...  This is an static ability of QEMU, and QEMU alone.
> It does not depend on QEMU's run-time environment (host kernel, ...) =
or
> the guest.  Correct?

The run time environment is the same as what is needed to spawn =
confidential guests. That is, the host should support confidential =
technology. The host kernel/distribution should support confidential =
technologies. Plus the guest should support confidential technologies. =
There is nothing additionally needed to support resets. There are no =
additional dependencies with host kernel/environment and/or the guest =
etc to support reset.

>=20
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Patch looks sane.
>=20


