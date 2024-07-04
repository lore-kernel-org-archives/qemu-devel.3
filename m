Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE173C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPD8e-00021e-EN; Wed, 03 Jul 2024 23:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPD8c-00020g-Mp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:28:02 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sPD8a-0005IB-NP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:28:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58d24201934so361763a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720063675; x=1720668475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:in-reply-to
 :references:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=uZxkbv+gv3TSjfxUWfV6RlK11u54sIiQfKEPCjJCi4Y=;
 b=DPc8qOaig0EkxzJRQGPj5Ia2VCOA5KV/6fwwS0ngupavldQv0tArmG/7a+DM/kFgnF
 ZkhlNqcK1Y8p8sFNNCY6FYxEWyAy5W8Bk6LxiA163IWR6HpO3Oe1infioUGVRwNByGzG
 FvhcJKmOy9k+Do9GvGWQKd/B/fIK22nEYkqOnPt3RXQt1YyoLoxbJ3TQ4q+XVh0D4zI+
 wbWteTQ/rPVOy1E/MQsgoLSfPq29aq8+cR5K6kXvWVxtDLBrgHy+bm4Xia8455uRBwAg
 WUsJ07CMXPP+1AyU7rv3CJj/U/ANB8WtDUT99A9NzCB9ohM7rU6U5apZjlkwyB4SC3LW
 e+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720063675; x=1720668475;
 h=cc:to:subject:message-id:date:from:mime-version:in-reply-to
 :references:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZxkbv+gv3TSjfxUWfV6RlK11u54sIiQfKEPCjJCi4Y=;
 b=mp+vrqRqA5iYBAIUOAmBxJMaXZWAD5AlumVE6eRLkfu6Rqvz0RdQSWi1UmZcj1m1dq
 rhrQrXneeuzePO9J42BoxwVt9n6YSTIlCkkMRWPlQNDPQlbHZS1BP2YncaTWOEskxzfA
 XOIHZftpEr0kkrnbB/AWxug1j+hdPiZxa4GN3A8sbSL74t11LHcLk0vnAKFXtS/F3wcV
 80sA+e/heZp2TiF4FUCIOi3OCZEpo62QafAbAaloKzXbExPOy2s2ojwmxQbXM4xuEibx
 hTFp56guSBAmR+peIUTHHaEhpOO6o+ooe28E8ptL8Z6gNHgPnKgV4f0o1AB8HNSVm3aA
 WfwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRBQfrPXYkfqmXI0o3UEBZ/WUge0O7kVQ3w4oL8+vLIMZxJknktQhF9GZk4QnUVemR4VypmzJXB+IkfV2bOAiKFArsyI=
X-Gm-Message-State: AOJu0YwGHGRLx3Q23Q8Te66joALJw0zuzyEgO6YzDeG8/+W6vw/j2bE/
 SD1FKQMP0o8BzjmVbs1/UDPRsuiWgy73o1CKdf1gd1+U5gqt36EJlj91NsTm5E5Y4Igp/bD8msr
 kF7F2OMZiQnrg5s4vILlI6kKooHyelqg6axHDAg==
X-Google-Smtp-Source: AGHT+IEvnMNgrGkzcpFndF0FcYtkq56BQIscedWSt96hgwkV6K/0QyV8gl8KPxVFXcVrNso9K7jpb30Y9Qi9Frx7R6I=
X-Received: by 2002:a05:6402:27d3:b0:58b:bb69:763e with SMTP id
 4fb4d7f45d1cf-58e7ad255aemr120997a12.7.1720063675011; Wed, 03 Jul 2024
 20:27:55 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 3 Jul 2024 20:27:54 -0700
User-Agent: Mozilla Thunderbird
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <8e6a16e7-21df-40ec-93d7-1b41fd0f50a4@bytedance.com>
In-Reply-To: <8e6a16e7-21df-40ec-93d7-1b41fd0f50a4@bytedance.com>
Mime-Version: 1.0
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Date: Wed, 3 Jul 2024 20:27:54 -0700
Message-ID: <CAO5cSZBOf1dBOoU-D1HFnBZ0LjCvnYmQJ9C9jWm3NB61WkTuZA@mail.gmail.com>
Subject: PING: [PATCH v6 00/10] Support persistent reservation operations
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 its@irrelevant.dk
Cc: kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pl@dlhnet.de, kbusch@kernel.org, foss@defmacro.it, 
 philmd@linaro.org, pizhenwei@bytedance.com, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000572fb2061c638820"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000572fb2061c638820
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The block layer codes has been reviewed by Stefan.
Could you help me review the scsi and nvme layer codes.

On 2024/6/27 10:53, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> the block layer code has been reviewed by Stefan.

--000000000000572fb2061c638820
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi,
<br>
<br>The block layer codes has been reviewed by Stefan.
<br>Could you help me review the scsi and nvme layer codes.
<br>
<br>On 2024/6/27 10:53, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt; the block layer code has been reviewed by Stefan.</p>

--000000000000572fb2061c638820--

