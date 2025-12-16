Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE18BD5C0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 04:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVMt2-00032j-M2; Mon, 15 Dec 2025 23:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vVMt0-00032N-9h
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 23:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vVMsy-000542-Dl
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 23:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765860126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25E4yBV+s+aVR64z/h7dM/6cC+JnZuFGUlMIIM26JEw=;
 b=HNyFJVJAJC1KTxEK4nT03mLi1M9is38oO8A8TdS4LXyXr8pf6qpnY7hhjMEYwdqrwS9s/9
 zzqiPwjCPHVQG5SOCHHhOA+5KZ4leGR80exwM4ac9YYzCLZlVnCP7dwT+qzUm9oScODOnk
 65q5emQp0KZvH2zA557VvqZsltUXgAw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-UM9me63WPxKELOunASNf9A-1; Mon, 15 Dec 2025 23:42:04 -0500
X-MC-Unique: UM9me63WPxKELOunASNf9A-1
X-Mimecast-MFC-AGG-ID: UM9me63WPxKELOunASNf9A_1765860124
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f25a008dbso32296215ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 20:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765860123; x=1766464923; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25E4yBV+s+aVR64z/h7dM/6cC+JnZuFGUlMIIM26JEw=;
 b=iHO61ilXheGvK3CG9GJOS9+Ds138gYrMGRE87TjqWbo+IdvhXIBXnaD+CwQyQRSasG
 ZbsqHliptxgLvgGHvhueLWFtQWEApNgKugXRcwUbZ5vo4OwA/JcDXR+M5yLnTnUpBMPK
 CWxSwWxDrL3SBS/3IrxN72GXQXF7MrHsshwaPDQK4adHpRA+REvNvAjuJzidHL0QjzD3
 ehOsnSM9uR4J6YMgEhZsGxb7bADgsYB1lcbqOoalFHArPI0/N29NChNEwuruDRYGipGD
 ZSJEq6+jbx1p9U/FmpsU8S9OXHN9DUE4vt7dN7UXb0Kp1ErQV87oxMusKAIX4CrO6pEt
 fOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765860123; x=1766464923;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=25E4yBV+s+aVR64z/h7dM/6cC+JnZuFGUlMIIM26JEw=;
 b=ZA+NEbN4aQ82h/mkQn+HblphsSRwCAInTfEC8/HjaMJRD+X2/5gJOjqbwIIdMX/UMm
 hT/CR/Zd6OaAkLzkJo6CcTfhSICx/o+nv1Z/bxQVC/VWiNXLxXBpdyq4Dw7nv2JusBa7
 7FOJbnnwEfiD7j+nKJZoGfNM3QP+K9yTL81p5XmYPBEUoL+lEYl8nlOYldLuucquvOYl
 xFtvW852TcEfxKwCuU7uO2gZ753deUiQnYaYjYX6HjhSSnWJS7sSy8u7gYvqNNqVaYph
 nYVpDRhKBnL7GspDxDjxMZHRPaS+6J/SILvwy+Zu2P09imCujdpwB9DNQKSSilyn6/Eu
 Hvqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULOsCkm1eEMgZ3sRUjF88OsHgJjm0e+LlR8kQkihrUWTPbOXGAduBrwfozYwdF6EE2YyGWpOr7CFhk@nongnu.org
X-Gm-Message-State: AOJu0Ywbfabk5szLlT0JG16f5IhkWbcOlVYkG2MMUfMpmjzd66ESNNkz
 hM4bto8yqotC/QS47vMYX54AVpgWYM0Z3dvvicC0zvrjLJJAvqsQFG0abhkBNv2QIRLVZYTwddY
 Rex9SMq9CRjh7B2OtLQgQi5wLDVnpnV/292U571UFCrv6O6CyKH3GRMjg
X-Gm-Gg: AY/fxX7i9Yy/lrmxAxnFogTTU5PyESiDjrTUeKAXJjsrjq23BJ0FbdKvGRoDRLoOY+o
 S6q6m/PB8Mb755/1ZTGXHx68xTseD0ikTvUxgZ0y/1p2WoW7ZxL2Iq4ZtixggVgfXTo1h4O2mxh
 JHXCXNOhoZJi6DzHsFQMV+P5V/lRPZXowGmrBpsbXAypi8Z6CrvmhKi0jh/Hm6UkEYilHASF5Ak
 e9t01YBchkA11aBCL//yPq/N6SpuwAwu4V+Hwh5XMtz3YLLWWbNVnHEdpmYUsncg6G/3DtguhDe
 vtWBKXvuHI4CCDQR+fE1mpvRggEQ2t/Jdr+ddaTuFDNRQvCxnVvK1sANO3cv7r6eVNizm/UW8g7
 fgEImHURcgDAtm+/dJI5eHCjcq43mv63qgUJp3gpXfKknQ+uQGZAgzB5rrA==
X-Received: by 2002:a17:903:18c:b0:2a0:97d2:a264 with SMTP id
 d9443c01a7336-2a097d2a4eemr102915895ad.37.1765860123499; 
 Mon, 15 Dec 2025 20:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9TFR9M+MI5ff/rcsLnk8MBVGLumJ3NbaBA7BIG1roNaofEsa3R+LPY0fw8vIrmhl/xcOX3A==
X-Received: by 2002:a17:903:18c:b0:2a0:97d2:a264 with SMTP id
 d9443c01a7336-2a097d2a4eemr102915745ad.37.1765860123109; 
 Mon, 15 Dec 2025 20:42:03 -0800 (PST)
Received: from smtpclient.apple ([223.229.163.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea04101esm148636915ad.70.2025.12.15.20.42.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Dec 2025 20:42:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 21/28] hw/hyperv/vmbus: add support for confidential
 guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <a0cfba30-8571-4153-a5a3-572cb2fe514f@maciej.szmigiero.name>
Date: Tue, 16 Dec 2025 10:11:48 +0530
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCE31E2E-19BA-43AF-9525-B99C45ADBBF6@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-22-anisinha@redhat.com>
 <a0cfba30-8571-4153-a5a3-572cb2fe514f@maciej.szmigiero.name>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 15 Dec 2025, at 10:34=E2=80=AFPM, Maciej S. Szmigiero =
<mail@maciej.szmigiero.name> wrote:
>=20
> On 12.12.2025 16:03, Ani Sinha wrote:
>> On confidential guests when the KVM virtual machine file descriptor =
changes as
>> a part of the reset process, event file descriptors needs to be =
reassociated
>> with the new KVM VM file descriptor. This is achieved with the help =
of a
>> callback handler that gets called when KVM VM file descriptor changes =
during
>> the confidential guest reset process.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>=20
> Have you actually tested confidential guests with VMBus or is this a =
change
> "for completeness sake" that can't be exercised in the current state =
of things?

No I have not tested the changes with VMBus. It=E2=80=99s more for =
completeness sake as you have correctly put it. If you suggest, I can =
drop the change.=


