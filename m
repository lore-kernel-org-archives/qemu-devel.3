Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA38CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbswe-0006GB-1v; Tue, 23 Jun 2026 00:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wbswc-0006Fk-GD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:41:06 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wbswa-0005Yq-VT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:41:06 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-30c03b09e02so9349502eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782189663; cv=none;
 d=google.com; s=arc-20240605;
 b=WpGhCCLh/XUImtg63oSmKaNM1z5jbJDv1QlbPjKWnzRueAnDDRRGRq/5LtU0rL2KD4
 6PoLYyRQtGr4GZ3NylGAHA5lOKxym65nT14T3WfInqO+jdvb7JqEaklBlieouMZIdYbq
 AH7c2kDaerrgxkaAp/wmBWa/hLLCEZ2mq9drsF6oaBGKQeq2DSBKpkHpPshr7mP9Qelt
 CIPyFW+okiZaMsyweffHZ+wU9MQhZvnl6aTDfznTgg+H4lwUX4E3xiOq6DWBpNjAxmIh
 j2tJLxToHVZRATiX8c3NjJRwkmZ9on9bDQipi6xy6UEKK/tvdUVcItX91HNOmnuAyanZ
 oCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z3BM/QQZ3WiByQI6OgMJQFbcNARaI8v1PcXIpM5OHUg=;
 fh=yGWAaXXYYQtYW+LCE7nyqmcq5QIuKbScqyYf4NVD8c4=;
 b=W68gVTFQETII6b3BH+R7sL4jPi4uxroG2KA01O+ElX0vhWrmi1VFLhuP+ig5ltwFv3
 Cl02hqgAynzH1YBLeYbbogNN/MHFT7S/KsstYbg8Mx8ALatBm+QcN8sNKqr25+gKEUqp
 G2RPlJP26ICi+WCw1GL87WeCQ0RD/bR1/6FTHKAZ12Qpeuod0qRHmpVAKfJ1LM7NARyK
 GArqH3hIsri8/nsyq9opoVNIZKZxfxOg2ZfEWALLSISURL3648XCXBJTbuhXFw+XkpuT
 Un5VHEo5qgNu/Pzw3Z/6neZhv0kNr00HoLRTbJ3mOw/qP+8atBU5blyFJNa+UN1dpkL8
 1B5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782189663; x=1782794463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3BM/QQZ3WiByQI6OgMJQFbcNARaI8v1PcXIpM5OHUg=;
 b=QaiCR/HMd1to8hzoUuRMr0VtsFFbc54xS7lGjHA0pLpKHp1fjqFjRmErHcS6VdhE08
 zDJUAwGILGWBErDnEtvvjrx5ioxGo6UGfmpQbXLkTxj/nZSiDoUtNdWw6V2GND62oDk9
 HB0m+NbRQ9iOKRlG9IK1kCY/+NlwLy68/rpF2AKUrPpgXD+mmqq6Y6dx7reRyXlAF++N
 gzxJbo97ICD0JBJAXtrKf57yMF3d71fu5CpOGZwBsI0wG3WB9rtOtc+FzNrv8oDjpGNo
 T7/E40bemiZPgmn+yTc/3Avutz6nT058UDvqW7t47AVg+ZkMhahaTeIVmKQarVRtTVPa
 4y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782189663; x=1782794463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3BM/QQZ3WiByQI6OgMJQFbcNARaI8v1PcXIpM5OHUg=;
 b=lsyRX3RzlXoeoTHFZmdwU2iV2BslE1YBwfNlD3eOqU1KEYwFZu7Zapm1YZAdLHHhn0
 LYFN7oqrfd8YaYzdIDXnWJnZQt+0AtoLW7R0FbA3nDHgK5HYOEoi63uSTI28+CVXffsT
 rLaltTJdpeNu+Z8YasNleSHk7MZtTSkAqWQqo9zV80JMfJyfjvgjxO4hrdZsSb1VpWbh
 /Rq1agVmMEkhIEXD0cXA+Ztdop2bwN3/N9t3dVZzNXlZtLEuSTQCwsjq7HQ9Pki6V6Zz
 3XB67CKg4oSm2Ji9HD0/Ga9qHUOH/+1VGTGima6RAxIeaON74tcvqbEJUykq4Yy1CtvY
 0eVA==
X-Gm-Message-State: AOJu0YyYur+3MO/CEq1S+35geQPD+ufg35bUCy5llvcvsdET6JsRFMeK
 gmYAXVoVp3nsJQGZ25B3Ysu+F/6HPdkzrenRZJZKbtmt4F/7ghF1+JNcTJpUt9NgMUnDrajcoG8
 bVyD+wHBFxcmXiwp7LKEu7xApzhdCEcWoJlzQ
X-Gm-Gg: AfdE7clOEbKCpcuh81c5+hwjqELQ5co4uRn/9h/g8wp2WVZuS+DKKXaPJq1Td3oxSQU
 J8XYGsWSikK9J18y2HD5sRhzXftl5Zu6ttD8elWJgGO21pDxAM1utjQEK4IqqoUM04zfkQTi4Se
 LurCPnu4Q5IOQX34V9XvyqwB1Y04n5r5J5OfMG2zZY5UFFe8Byhy+WTsxSrOK9synrEjzTtHEze
 BWHbY4nF5QSuZrs9sYaRh/y8Mx/068LuXq7Ap+Maa6XTbophbhoFp7vPDVGfr051cvlU54M
X-Received: by 2002:a05:7300:e125:b0:30b:e4a6:1ab8 with SMTP id
 5a478bee46e88-30c58a984fdmr1062831eec.13.1782189663180; Mon, 22 Jun 2026
 21:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260608091815.31303-1-apolivodaa433@gmail.com>
 <CAGscdFs9AaxPTDCu_bpaMpeh4yqZ1BDwZ0yjo81CAZzJuAOW2A@mail.gmail.com>
In-Reply-To: <CAGscdFs9AaxPTDCu_bpaMpeh4yqZ1BDwZ0yjo81CAZzJuAOW2A@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Tue, 23 Jun 2026 14:40:29 +1000
X-Gm-Features: AVVi8CfLgANBcpVcVP6gUbFi4L1GxX00rFbMppqcImCx2YRjYC881ZGF09bDh4w
Message-ID: <CAGscdFuH8t+5QqV3NKH4mwXBdd3M30fmbDET7nYi604fRa_dbA@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: helper_sysret(): Check that RCX contains
 a canonical address when emulating an Intel CPU
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cbd9500654e45d0a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000cbd9500654e45d0a
Content-Type: text/plain; charset="UTF-8"

ping
https://lore.kernel.org/qemu-devel/20260608091815.31303-1-apolivodaa433@gmail.com/T/#u

--000000000000cbd9500654e45d0a
Content-Type: text/html; charset="UTF-8"

<div dir="auto">ping<div dir="auto"><a href="https://lore.kernel.org/qemu-devel/20260608091815.31303-1-apolivodaa433@gmail.com/T/#u">https://lore.kernel.org/qemu-devel/20260608091815.31303-1-apolivodaa433@gmail.com/T/#u</a></div></div>

--000000000000cbd9500654e45d0a--

