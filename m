Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE68C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3uLm-0003iR-1Q; Tue, 08 Sep 2026 07:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amanasrani1712@gmail.com>)
 id 1x3tRT-0006Tv-Ny
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:52:43 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amanasrani1712@gmail.com>)
 id 1x3tRQ-0007sb-TD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:52:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c25420fe973so773602966b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788864757; cv=none;
 d=google.com; s=arc-20260327;
 b=rBKfy2ok19vA4PdjUixwVBL+1St21MQpWi8eHKMlz4ARrmqSsQxuO0/BYtHYUq2T5Z
 RSxEMB0iIDEuOHypFWrnhMuKAtEfDPdZuSoaZuRIv8MrNWRhQmvhrgs5VTWy0Kbiv8TZ
 dNrVQHMhFlEexXp5u08pUWn8chTb/Ebc72NefZ8VSzJY4JXdM4RUgaZCn3oHa4K6fNom
 9brRI+6PpTKEpvVj4dtoueHGTVCHsBpX0HmU202M8JfTuHjmLu9b4tASavxbbmE/eJqa
 65Jbru6Wml2hTZvCCHgOTAA65fR3Z6tGSzggLCjiIBBG0xxaa6KV91iPPH3B02R6U77f
 odCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XmXeGDVaSHrtWQYZQvWbNRpBbddsVjtNqmYa6sVo26Y=;
 fh=g+yJdW1uBGuJ+1nW1d4+Coiwtv4NRtc4WCDOp08gzw8=;
 b=pnBNTIfZvrDXhSadJP7Xx/KwuFSGMGDr4jtnHeIdch8qZqp48iRyqndd+vG7GqJlm5
 yRpacThMosHMlAKyoM6E8aeMX0XHgVtmbd6C8zU1tXCpjF7lIey41TF/ADl0w2W6hfl3
 hXAsB2//UhTgF7Jc00rHik3iI/AGH0PFQxDjJ8r0ZDwng73rNqnBWJTQDiokJrOPGEhS
 qHtLc1A5qWSWBJjFFHFp+VIKmsiyNb9xkNMPLxhA4CyK8TuolO39uzqszzyAIzze/MDf
 OhBO/nYD+XDaS7ogRldjneZTz36hg1F2/1b38eG3ofSfljTFMHpitYYz5M4thZc7Y2Fi
 6Fzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788864757; x=1789469557; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XmXeGDVaSHrtWQYZQvWbNRpBbddsVjtNqmYa6sVo26Y=;
 b=p5Lp1VeUv/xT3RcfaJ8d6ZxPtWErbrhvIRsIUmNtkvmD3StPrKAPqn9NdZkl40Gcoo
 qeQAiQgUVu2KPwkDoCM6zTBtj/O5VfQWHlj+5H4hlsUjfC5uFAuFdSt0L9LKqnxP1kPg
 pKZ5/CqHnqgwnhZ7RkzrtGmElHhqrcr/i2QVwfa+fs1qxYn/tXaQgXTI5w+LYhXeC+e2
 RPnIQuDcq/5I4kUlvfh6uYO038AGy5V+Vi4P0r6XhvkzNz2SVfYVz3c6fBhrCdsOgdNd
 PIJzxkJcaIVOzlQ5e8qcTpLK9HVTia/M9erVV1T0JEVfda4jrMZrPmmidbqcnPLUOJLB
 F/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864757; x=1789469557;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XmXeGDVaSHrtWQYZQvWbNRpBbddsVjtNqmYa6sVo26Y=;
 b=GjsNC0H/tbvuBCMOhn9L+yyr/6VRRt5Ui7KZZ6KEJVQKYFscthFOAaeOy8vpnctj8v
 BhCrx0n43dYhdq3EwoEIPb/iTW497Yocud2APPQ72A3oHRPfb6AKyXU9R8TaFD1qx8ZQ
 Y2S04Nn8wpUitz3CV6xgmsECXRefI5hqOcBeSXTuBlvkZAwof/+GWX77GdGskCVCOvSb
 6SZKqOEs9xTawSRcr9ZEqHX1aY8dD/lvPQUoBFfzPor6jz7aOy0Zi/H9TyEbOhsYxf2O
 AM+JA/8Pbu/rFrX/d+itFuEWSIVxkjzPVFqB+VJ67UZMzxehD3KVS0H2axFHU+Ng9CUD
 Xdng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP/Cv4SqbQqjA8caWdJdC+XhKeAR+VLRU4qr9K8EBRGYh7tdHCBKmRKUfeRddplUW/u03ShaKEQtJL@nongnu.org
X-Gm-Message-State: AFuF++nCKHgOJMAY4cnfjXSu5aHy+V2Ei3Mgzy4PmP/jncZU2/aNsl1i
 6HpB47lUv7hE1ifjWCRGYynt4ozgtxq9od2qTThpBd7nvddqlMQnnSRIr0TOHJNhtOnME/r6rMP
 MrPt37pJqaMxbJmMQqRB4FLjkzif8oN0=
X-Gm-Gg: AYBFou0ke6fTKmpnxPuReZnyzBVAoMqEoYNq3b+BpHBx/tSbLQyU8dInAi/vLhyubLb
 Aj9nDtCR1RWDf4r9VfjeZCcsPcKnFFsbuidPC4cJMe1tW5Kahx/QExmn3GCQ6OkUXYO6C63/1Wb
 RyPw/Xx4vW5lm4lvN/2/JmG1ddMyxZlqf8oFUQac6CFxamXcU1fwE8YpQFdrM8s5VObNioROYRQ
 J9pQWN7l+6sluftuwGR89eqh1dzhISnkN5mqrYbjoi4Y7e2dGqvmwKQ3as8gyFYsZhhNSTq3zZK
 DT3WubjIQrJfSjSRHvTF5HdV3YebUpOxZWI3/1fAuNKS
X-Received: by 2002:a17:906:eec9:b0:c26:19de:912a with SMTP id
 a640c23a62f3a-c2619dea136mr873385166b.29.1788864756687; Tue, 08 Sep 2026
 03:52:36 -0700 (PDT)
MIME-Version: 1.0
From: Aman Asrani <amanasrani1712@gmail.com>
Date: Tue, 8 Sep 2026 16:22:25 +0530
X-Gm-Features: AcwNN1USa0pPD0MsfejfbEjz9zjPQg3QjpcX19I70PHvBvMYWnCr1tisXhLkVKc
Message-ID: <CADExdLCU82TQaQ8+Po1cJ4QVdeyvMJmnY+JmnJtQn_xgztdQRA@mail.gmail.com>
Subject: [stable-8.2] Backport request: rbd: Fix .bdrv_get_specific_info
 implementation
To: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005fa892065af688f0"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=amanasrani1712@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:50:52 -0400
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

--0000000000005fa892065af688f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to ask whether commit 4af976ef398e ("rbd: Fix
.bdrv_get_specific_info implementation") could be considered for a
stable-8.2 release.

This refers to the original upstream patch submission:
https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04048.html

I am aware that stable-8.2 is closed, and that stable releases normally
follow the currently maintained major release. I am therefore asking
knowing this is outside the normal stable policy, and I would completely
understand if the answer is no.

The reason for asking is that Ubuntu 24.04 LTS ships QEMU
1:8.2.2+ds-0ubuntu1.16 and is supported until 2029. As a result,
deployments using this QEMU version with Ceph/RBD storage can remain
affected for the remainder of the Ubuntu LTS support lifetime. The fix is
present in newer maintained QEMU branches but cannot reach 8.2 through an
upstream stable release.
Impact we measured

Environment:

   -

   QEMU 8.2.2
   -

   Ceph RBD-backed volume
   -

   rbd_qos_bps_limit =3D 8 MiB/s
   -

   Discard I/O in flight

Under this workload:

virsh domstats --block
=E2=86=92 ~60.39 s

The whole guest becomes unresponsive for the duration. The guest clock
loses approximately that amount of time, and the console reports:

rcu_preempt kthread starved

In comparison:

query-blockstats
=E2=86=92 ~0.142 s

does not exhibit the issue because it does not call bdrv_get_specific_info(=
)
.

Our investigation indicates that the blocking rbd_read() in
qemu_rbd_get_specific_info() runs on the QEMU main thread while holding the
BQL. Consequently, vCPUs stall when they need to access devices protected
by the BQL.

This is reachable during ordinary operation rather than only during
connection failures. libvirt issues query-named-block-nodes alongside
query-blockstats when collecting block statistics, so a monitoring agent
polling a compute node can trigger this path. Since librbd's QoS layer uses
FIFO scheduling, the small probe read can queue behind already throttled
I/O.
Backport validation

We applied commit 4af976ef398e to Ubuntu's QEMU 8.2.2 source. The patch
applied cleanly with no conflicts (only line offsets).

We built and tested the patched version, replacing only block-rbd.so.

Under the same workload:

virsh domstats --block
=E2=86=92 0.151 / 0.150 / 0.141 / 0.153 / 0.150 / 0.144 s

The guest clock remained continuous throughout the same 60-second discard
workload, and we did not observe the guest freeze.
What I am asking

   1.

   Is an additional stable-8.2 release containing this commit possible at
   all? Because my reseach shows this commit is only after 10.0.1
   2.

   If not, is there any guidance you would give distributions maintaining
   QEMU 8.2 for a long-term supported release?

We have also filed an Ubuntu SRU request:

https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2166503

Even a clear confirmation that stable-8.2 is closed and that this should be
handled entirely by the downstream distribution would be useful, as we
could pass that guidance to the Ubuntu maintainers.

For reference, Red Hat has also backported the same commit for CentOS
Stream 10 / RHEL:

https://gitlab.com/redhat/centos-stream/src/qemu-kvm/-/merge_requests/399

Thanks for your time, and for the fix itself.

Best regards,
Aman Asrani

--0000000000005fa892065af688f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>I would like to ask whether commit <code>4af9=
76ef398e</code> (&quot;rbd: Fix .bdrv_get_specific_info implementation&quot=
;) could be considered for a stable-8.2 release.</p><p>This refers to the o=
riginal upstream patch submission:<br><a href=3D"https://lists.gnu.org/arch=
ive/html/qemu-devel/2025-08/msg04048.html">https://lists.gnu.org/archive/ht=
ml/qemu-devel/2025-08/msg04048.html</a></p><p>I am aware that stable-8.2 is=
 closed, and that stable releases normally follow the currently maintained =
major release. I am therefore asking knowing this is outside the normal sta=
ble policy, and I would completely understand if the answer is no.</p><p>Th=
e reason for asking is that Ubuntu 24.04 LTS ships QEMU <code>1:8.2.2+ds-0u=
buntu1.16</code> and is supported until 2029. As a result, deployments usin=
g this QEMU version with Ceph/RBD storage can remain affected for the remai=
nder of the Ubuntu LTS support lifetime. The fix is present in newer mainta=
ined QEMU branches but cannot reach 8.2 through an upstream stable release.=
</p><h2>Impact we measured</h2><p>Environment:</p><ul><li><p>QEMU 8.2.2</p>=
</li><li><p>Ceph RBD-backed volume</p></li><li><p><code>rbd_qos_bps_limit =
=3D 8 MiB/s</code></p></li><li><p>Discard I/O in flight</p></li></ul><p>Und=
er this workload:</p><pre><code class=3D"gmail-language-text">virsh domstat=
s --block
=E2=86=92 ~60.39 s
</code></pre><p>The whole guest becomes unresponsive for the duration. The =
guest clock loses approximately that amount of time, and the console report=
s:</p><pre><code class=3D"gmail-language-text">rcu_preempt kthread starved
</code></pre><p>In comparison:</p><pre><code class=3D"gmail-language-text">=
query-blockstats
=E2=86=92 ~0.142 s
</code></pre><p>does not exhibit the issue because it does not call <code>b=
drv_get_specific_info()</code>.</p><p>Our investigation indicates that the =
blocking <code>rbd_read()</code> in <code>qemu_rbd_get_specific_info()</cod=
e> runs on the QEMU main thread while holding the BQL. Consequently, vCPUs =
stall when they need to access devices protected by the BQL.</p><p>This is =
reachable during ordinary operation rather than only during connection fail=
ures. libvirt issues <code>query-named-block-nodes</code> alongside <code>q=
uery-blockstats</code> when collecting block statistics, so a monitoring ag=
ent polling a compute node can trigger this path. Since librbd&#39;s QoS la=
yer uses FIFO scheduling, the small probe read can queue behind already thr=
ottled I/O.</p><h2>Backport validation</h2><p>We applied commit <code>4af97=
6ef398e</code> to Ubuntu&#39;s QEMU 8.2.2 source. The patch applied cleanly=
 with no conflicts (only line offsets).</p><p>We built and tested the patch=
ed version, replacing only <code>block-rbd.so</code>.</p><p>Under the same =
workload:</p><pre><code class=3D"gmail-language-text">virsh domstats --bloc=
k
=E2=86=92 0.151 / 0.150 / 0.141 / 0.153 / 0.150 / 0.144 s
</code></pre><p>The guest clock remained continuous throughout the same 60-=
second discard workload, and we did not observe the guest freeze.</p><h2>Wh=
at I am asking</h2><ol><li><p>Is an additional stable-8.2 release containin=
g this commit possible at all? Because my reseach shows this commit is only=
 after 10.0.1</p></li><li><p>If not, is there any guidance you would give d=
istributions maintaining QEMU 8.2 for a long-term supported release?</p></l=
i></ol><p>We have also filed an Ubuntu SRU request:</p><p><a href=3D"https:=
//bugs.launchpad.net/ubuntu/+source/qemu/+bug/2166503">https://bugs.launchp=
ad.net/ubuntu/+source/qemu/+bug/2166503</a></p><p>Even a clear confirmation=
 that stable-8.2 is closed and that this should be handled entirely by the =
downstream distribution would be useful, as we could pass that guidance to =
the Ubuntu maintainers.</p><p>For reference, Red Hat has also backported th=
e same commit for CentOS Stream 10 / RHEL:</p><p><a href=3D"https://gitlab.=
com/redhat/centos-stream/src/qemu-kvm/-/merge_requests/399">https://gitlab.=
com/redhat/centos-stream/src/qemu-kvm/-/merge_requests/399</a></p><p>Thanks=
 for your time, and for the fix itself.</p><p>Best regards,<br>Aman Asrani<=
/p></div>

--0000000000005fa892065af688f0--

