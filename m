Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E286FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59h-0006Wg-Rl; Tue, 07 Jul 2026 08:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wh59c-0006Vf-Qa
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wh59a-0005Cg-IT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpPymepMy447GmnlvRU9c3Yl/vG1WZSxeP4M47GU3p0=;
 b=bhjjug/lIvXaknfAuu6Xtu022JmtwBNvEE0akPxGAnzUi/5o+HLQycWUJMalAKQ/Rhrg5F
 uAbV51gCR9THOSCUIuw0H+4b2KH+UNBk1aAfNZVFsMimEP+pjeIIxh9LBlsf2di9tztzAg
 UMFjm6K5IRpOQ5qin7zpafg7vWoIe0M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-DYsin2icOdWb6JS4o8jUFQ-1; Tue, 07 Jul 2026 08:43:56 -0400
X-MC-Unique: DYsin2icOdWb6JS4o8jUFQ-1
X-Mimecast-MFC-AGG-ID: DYsin2icOdWb6JS4o8jUFQ_1783428235
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso83105405ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783428235; cv=none;
 d=google.com; s=arc-20260327;
 b=dJBOMV1TU+BlT90e+PYzGj60vZUAhJNYZAEWPaxH/RoA4hPE68YlqllzNYE5nxoByo
 vmQB/lrFHipyWW/Ycr5ScsgOrHBFoJYbQeKHsUG5os41H6PjrXpJH45UFvMtDczi7O2G
 ds7Q6NJN4HWLR9Gm2vXW6cwWIHlPgRerRF8NS5WLlHXT3cD+1Xup5XfDEg0S5u8QiuKu
 kGe/c7c8XhZy1NzK0TV5OWJFf364jvPyxwmcq8cc+cTww0uCRNWGDJetZWKkhgPDZt9g
 0g2+qJzbUpqvqZiTQsDz3GcZru4DgUiJusO/gUaKpdEt0IeGHRo//JuOgHPgAWOYgDGT
 0mcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DpPymepMy447GmnlvRU9c3Yl/vG1WZSxeP4M47GU3p0=;
 fh=NRCqC45ZfLgqv9MnUKNLzeqsdSlRhMXcHQL+qsXe7Ak=;
 b=dmaiClwD+ca9g/lbZauXEqdOsBX+Ryw3A43Rnhd7M+NJtb25g1F+l/hk3ygtGWXNVf
 3AanKrYIwUjudVeHrTQL3ZkLFiB2v/td3N0rS2skEeXGM7xQtVvhqKCe1lwMiboXyU0q
 JUdJuofZkPEwLKGF4wcproComBCt+vvcNjA4jGkzSDE/8HzJUSDdYu9UG4G9t4JoiRL8
 VC4JezoH6Bn6HC5FSykeMO+i87/qUTr5+ic01IKPumQDPQurgjiFbp3RUWmRQpJX+Q5b
 lfcX153qVaUIGNRE6zq65FsZGqtph8wl86HpI127pbW6tZ5gx6mehMLD/UxpJXKfQi3H
 oSrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783428235; x=1784033035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DpPymepMy447GmnlvRU9c3Yl/vG1WZSxeP4M47GU3p0=;
 b=Ir3QtSDZFPVPgFQxWbcB9vbyQRCiNygVN1+ePnUuourV25SwiJrEzAl6Q3ThR+i1fZ
 oBcgFddwoGi31XELkoxZPF31jCX2bw6uQu9JTViRcud2p/aqdYIeMVsjZkTzokxikdMD
 eemIvtSCdPa8Wr1CX45m3yXvPUVLIF2UF8ZQtRc/4qDoZLk6S3AGWe9cudvaN6FeNF3U
 wMj7TGAmk28S6JX3Vkcp5feigqqT4AtAgOMSi3zDe5LsvPXc+unQ0vp5Aj+5vf8hU3TA
 lzkQyyhLkigMBWP88QWZZBGjVPsb9PlS/cz6uNWv4Kdnt2wlplZ5rVz63QkPMzW/0LMY
 Tjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428235; x=1784033035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DpPymepMy447GmnlvRU9c3Yl/vG1WZSxeP4M47GU3p0=;
 b=YVTkBuWsoBk1qW0qwvc/+y6SC6br1U1tQd9jWIXQOHecVE6ljTNZP2oNQ1R2UuCEQ2
 OhByGzX1COEXJtHFOg6kjQZs/ucdyvUpb6goO8t3UdZSFmAvvZlTEeLLhthOBI1xt91w
 rlKEtZV9vP6IO8slqJy11XijApR+wmPFUc0rYj1zQOOSKUOBZo6Y0QFp6qzbZpT7RYhH
 JR3gtWwgxsCzkwGyQb/7ZAGtooPhHkWbF8N+LmkXebPXZJfAK79pdXbtfSXgDfe47hvR
 QX8+CML4zJSSdMwEsKyyTBGCrcJbY4KqiX5fqlTpf6GmrRYdUcKCigmw8+K08NmLK0fj
 hQAw==
X-Gm-Message-State: AOJu0YzJpoNw+9LM4MVngdF2LRwTzhxNtxyYQAqIBj0lNk3r8f9c+4Id
 1bqkzDZHgncCQuRi6J2R9tXhmQfnknXH/kjbiUTSQZtaP/2IZMZZmYd+7qMJXUI14Iob8b2VdhX
 5Fb/Z7hycARGmKzC4M0A+XkdqcucUOfdMpx6bx53DmX88IM5OVbLOtpPd6SuWbK7057ag0nqKiY
 yZSsn4/u9rIHOQmdU9Sdq0vlL1sGxcpAM=
X-Gm-Gg: AfdE7cnBLqMqE5bqCiphK2iYQ0R8ImkAsS9m7AbvgShWKFFgUHY2uiChk36VxkEjTsb
 ySOCy7NZhima/hEiEiSE/oXXCgLGRqKQOHL5DuYdmi0D67yiiRjnNvi+PzHgns3WzQeX4XAopQg
 V60ILFV0+zQ98/6AGGEdhCGq6UFUsLGiNdZ71Kgtn8KbGToR9l/2Y9v3KG4ncHuyNgSO3Yb1bPV
 +nkbL37qOcOg14ymQO1JX5qVg6iHJ5AMzOMRDY/nAFxwFqebslJovYxa8EFAzPJPvpFmwBpuYxp
 sE6B3Sqx3H3s
X-Received: by 2002:a17:902:dac8:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2ccbf051466mr49859435ad.22.1783428235366; 
 Tue, 07 Jul 2026 05:43:55 -0700 (PDT)
X-Received: by 2002:a17:902:dac8:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2ccbf051466mr49859145ad.22.1783428234849; Tue, 07 Jul 2026
 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260707105927.2776822-1-berrange@redhat.com>
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Jul 2026 16:43:43 +0400
X-Gm-Features: AVVi8Cexu__l-4XSda8SdqoMZivVSr_1zS7kBe2SFcc9wgIRL67ugNifnss1XpE
Message-ID: <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

Hi

On Tue, Jul 7, 2026 at 2:59=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> Beyond the overall virt/non-virt use case classification, there are
> a number of scenarios which we have decided will not be treated as
> security issues. Start to document some of these to give consistency
> in our treatemnt of incoming disclosures.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> Mauro / Michael: please suggest any other rules which we have applied
> historically on qemu-security disclosures that we should capture here.
>
> The vfio-user/vhost-user addition is a new one based on discussions
> in some GitLab issues today/yesterday
>
>  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 53992048e6..fbbca50f95 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not=
 considered security
>  bugs at this time.  Users with non-virtualization use cases must not rel=
y on
>  QEMU to provide guest isolation or any security guarantees.
>
> +Security boundary scope
> +'''''''''''''''''''''''
> +
> +Even where a flaw affects the virtualization use case described above,
> +not all scenarios will be considered in scope. The following guidelines
> +are used to evaluate whether to apply the full security process, or trea=
t
> +an issue as a normal bug.
> +
> +* **assert** / **abort**. If triggering the code path requires kernel
> +  privileges (or root account access) in the guest, asserts/aborts in
> +  QEMU are a self inflicted denial of service. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggering the
> +  code path can be done by an unprivileged guest OS account, this
> +  **may** justify handling as a security bug.
> +
> +* **vhost-user/vfio-user backends**. The backend processes have
> +  shared memory regions co-mapped with the QEMU process. The intent
> +  of the process separation is operational resilience & flexibility
> +  and allowing for independent software suppliers. There is not
> +  considered to be security boundary between QEMU and the vhost-user
> +  & vfio-user backends. Thus flaws in the backends which can cause
> +  crashes / undesirable behaviour in QEMU will **not** be treated as
> +  security flaws, but should be fixed as hardening bugs.
> +
> +* **memory allocation bounds**. There are many ways in which a QEMU
> +  process can legitimately consume an amount of memory that is
> +  significantly larger than the assigned guest RAM. QEMU's worst
> +  case memory usage should be considered effectively unbounded. As
> +  such the QEMU deployment on the host should account for the
> +  possibility of large memory peaks and apply countermeasures to
> +  provide continuity of host operations. It is typical for the Linux
> +  OOM killer to reap the process triggering host memory overcommit
> +  in the case of exccessive usage, offering a degree of protection.
> +  As such, bugs which can lead to excessive/unbounded memory allocations
> +  will usually not be classified as security flaws, but should be
> +  fixed as hardening bugs.
> +
> +* **degraded guest behaviour**. There are a set of bugs which can
> +  lead guest hardware devices to misbehave. For example, a flawed
> +  virtual IOMMU operation may not offer the guest device isolation
> +  that would otherwise be expected. If a guest triggered exploit
> +  requires kernel privileges (or root account access), and leads
> +  to sub-optimal behaviour of the virtual device this is considered
> +  a self inflicted service degradation. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggernig
> +  the code path can be done by an unprivileged guest OS account,
> +  this may justify handling as a security bug.
> +
> +* **nested virtualization**. The scope for nested virtualization
> +  is to prevent a level 2 guest from breaking out into a level
> +  1 guest. As noted above, a number of scenarios exclude security
> +  handling for flaws only exploitable by the guest kernel / root
> +  account with affect the guest's own service/availability. In the
> +  context of nested virtualization with PCI device assignment, it
> +  may may be possible for a level 2 guest kernel to trigger flaws
> +  that affect the level 0 QEMU process. While these bugs should be
> +  fixed, they will not be triaged as security flaws at this time.
> +
> +* **low severity impact**. As a catch all rule, issues which
> +  are judged to have a "low" severity impact on the system will
> +  usually not justify handling as security bugs, nor assignment
> +  of CVEs. They will be fixed as routine bugs when time allows.

Should we have a section about management-plane protocols? (migration,
QMP, monitor), since they already require trusted network access?

> +
>  Architecture
>  ------------
>
> --
> 2.55.0
>


