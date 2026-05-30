Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5CDCD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 14:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTL7P-0007BK-Dj; Sat, 30 May 2026 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wTL7O-0007BC-63
 for qemu-devel@nongnu.org; Sat, 30 May 2026 10:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wTL7M-0004Zf-Nf
 for qemu-devel@nongnu.org; Sat, 30 May 2026 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780153010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=KrgN+/IE6PA4Nu2OKHuml+af+qAz1xXZaa3UKnuqzBQ=;
 b=HenKynm2Dt0ZijOwFZri47bbJ/gB6650NeojpdL1NaP3skWIBdb3g20AHdVnM7K3CWNxOj
 hDknrIslaGjE1nA5joZfpBjgGMC/KPczJS62HSulz/02mMWnWWCD4J2Xs4+ou9coHWmQMm
 sPVDIL+9kyduKLP23P3ZxcV4gKWvU+w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-PTqNzVSwNRef3R3-nCdCqQ-1; Sat, 30 May 2026 10:56:47 -0400
X-MC-Unique: PTqNzVSwNRef3R3-nCdCqQ-1
X-Mimecast-MFC-AGG-ID: PTqNzVSwNRef3R3-nCdCqQ_1780153007
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8c3bdb60dadso135101116d6.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 07:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780153007; cv=none;
 d=google.com; s=arc-20240605;
 b=i1UXi7nnKhJtNWXD8k2LNBOVfBcBH1K24Ovthy+h9DNyyNGt2ybtfIl3HVKluQWL0k
 V0bmXznw1lUCGyGU6C3UV+6d0Q9Qm2+3zbWNTonxWRLv5n7P3m5pyDvnjUeb48NBnjCP
 SRvwNL220BVUwgmeqjuTsVWt/JSo3+Ivpme6HAB7ToB21lzffhP2ESlOhAiBp0akRR/2
 RKn2NZZ8txTbekRXkxQkpD96R2lxAjKnpqKLKumibHXUwyucutD9yS/m+Lb3cHRtKvBL
 Ew88DzUpVjX3ojYqzN/rpBM9J469/jYnfQTjEBRPE2/mV+H7w7SHs8UpnuT3Z4Da783x
 pMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=KrgN+/IE6PA4Nu2OKHuml+af+qAz1xXZaa3UKnuqzBQ=;
 fh=OxaQKzCgn6hyn0RCh2n2TYHljlQPbG7ri9jbfVYTE3I=;
 b=DuQ9cO4YgPcq9Rf4WTqoyfQAl5+/1bTHLA1i8+yRU407mGSqnSfmulCQycPyQ8FmPS
 ZI0mdVNP9MXIWazQyd4oplNXkjlqcuwioZrrDXb5QbODDDfJm2etwiY7qcRA/txI4CO/
 9z2B2DWFtZQ8jk/Dx9aJMGjgr6Fir2uog9wb2Opqm464hC5y5iv84vyZiF+EclIirQH3
 /zGbY9mvXfBFVtN11PyF/yIXsP6OSOUonImYD65cKNaobqcFD1oB82c0XHV3DkpLeVPN
 /rHdxW2P88vf+eirMC/Agc710C14CHXN1QiRsXz7iIkXCIvRuJWp7ycy14iiTXfjKdfB
 8sPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780153007; x=1780757807; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KrgN+/IE6PA4Nu2OKHuml+af+qAz1xXZaa3UKnuqzBQ=;
 b=En0MFYXRm+WN7HYCKXkyP4j2GrSuLYow2xI+D3sinM6/oKQyy3jnX9tkYHVZJdN1iM
 NnEnfNXvmegMgvKLDXExRgR5hNrE9ve3grPm0eJaoVXT8g7jCNYSeZdhDQY6NektwulD
 TpxpLQkiuQU4DCzi7J9tYLPjKR1lKoXweOvb8V9jW8fH2aL68FnWFPT1T+tVNWzeQ60c
 4S5N2539qCKz2FKBd7raAMS6hQz9hY1/6nVHytjOpiEvViKMjftrHaUEuskkyRKLbKsW
 dgG3J3N03V1dC/SngZ8PYWg/wbHaaQptHeu3SFBOUtSzcl37uuZBst1YGiKT1VOq5E+e
 ONNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780153007; x=1780757807;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KrgN+/IE6PA4Nu2OKHuml+af+qAz1xXZaa3UKnuqzBQ=;
 b=AeMEbFxyBSRjGwCOHx7gLJSrjkK6O8nPr83/VsdchnD65KmBomcBjPEbRS1btfPKO0
 74HHLttweq7oYTpJRPNHa5rr8eQuGR/ZfJHdX46dGepggyQpXBDZGf82FluIU/71TAIY
 DJ91dO2YzanoaeSOLTG9LobeQrURpIhRu476WhB2fduJcAGwOyVrZmlIexrFiCJFKGr9
 cr/NuvP5uKTT+FjkV/sIqhTGwtcKe4JUoulp4+1OLZK9x1QwWqhADKdnz0WX/AOlrinB
 wumPNUJSXFQ0mWVbeD3KTLzqeB1M8jRuYdV3QhPtbYmf6aQPYylo9JDjzybz0Xq5lwai
 cDiA==
X-Gm-Message-State: AOJu0YwbLeWO/sY6j4DF9UqYOUuCdx8w7g5OMRcKei+o9iRYzCpcXhkJ
 yZZlR51Na1CLk4mDqU41lGyVyN6QgQ57mPOugMiAHFK+jhEqPs/hnzDj7n1PKcjLuKCSl6x0FFl
 2XbC41UyziHDX60llT/2cC5uVBsBPuwNxvUgvt2VRmmxMIhHU73dloomTJD20fYPEVdH8nVz1TM
 RzXXfQpHDOTi5GkBkQ6fcIkhEAn5zEj3RtpXDbVbI=
X-Gm-Gg: Acq92OHFu+3dJK9Mm9SJzTLYvVJr7UPMLjUywvh5mhnmEwd5tzdR+hVn50Yt9xMf4Of
 CruB0dOljnW+nGCDByzP/QFt95lOQ1fu1A01N+umMjHQTGbcdHEawW+EkxrIp4CWZYV+OGh2Chb
 BRI05jOMYiSRM8dIUVWfcxd6rOTLSlqNma1sb6miYqt3hsMOCQJSeoi9AxJw6RKIu/KaLXYpaul
 OkskmYzaEQuzA8fttytrkfMDdUYyjKC9FF9WZ6afHnXVIcY2RN5+2UDLWnJJ1qPrCKceQcBsJIB
 yIMJ3/k=
X-Received: by 2002:a05:6214:cc2:b0:8cc:d606:1762 with SMTP id
 6a1803df08f44-8ccefdbd942mr69832976d6.22.1780153007379; 
 Sat, 30 May 2026 07:56:47 -0700 (PDT)
X-Received: by 2002:a05:6214:cc2:b0:8cc:d606:1762 with SMTP id
 6a1803df08f44-8ccefdbd942mr69832596d6.22.1780153006949; Sat, 30 May 2026
 07:56:46 -0700 (PDT)
MIME-Version: 1.0
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 30 May 2026 20:26:34 +0530
X-Gm-Features: AVHnY4Ks6TTqCXTr75Wv5SHklTJcxWZ9WsbENBU4iu7vc__jmy6XQQckWo1w1eY
Message-ID: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
Subject: artifact download for qtest
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I am trying to write a qtest for which I need an IGVM file. I have the
file, about 54 MiB in size. Instead of committing this IGVM binary
file with the test, I wanted to check if I can put it somewhere, say
in a gitlab repo and then make the test download it. This would be
similar to asset downloads for functional tests. No this test cannot
be a python functional test.  I am wondering if anyone has faced this
situation before and what the best way to solve this problem is.

I am very much aware that bios-tabes-test has a bunch of master acpi
blobs checked in. If I recall correctly people dislike this approach
for future tests.

Thanks
Ani


