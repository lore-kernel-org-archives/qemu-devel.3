Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710F1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8f3-0002gX-8W; Tue, 07 Jul 2026 12:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wh8f1-0002fx-J7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wh8ey-00026n-S2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783441715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0I/nI52MIs5GzVAFcrNJugmgh9WN9J8EKhjNI4DSRk=;
 b=L1eD0mLSwvTSXHS17XU2cJ9YYlvqBhMymP4O+jWzRnggFYauj86f3qjNvaYc6D79oQb7CJ
 WIl9q/drl1t8WysFlKspweibo8AU55OaeVeQIKSwwHQhdmYNzIxWbyK0+19FDRKhuZHAHh
 VaL92Xn8BnrTUGDxZTe9imKqFyOWjp4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-2UHi97AaNNiPUCdum41-Gg-1; Tue, 07 Jul 2026 12:28:33 -0400
X-MC-Unique: 2UHi97AaNNiPUCdum41-Gg-1
X-Mimecast-MFC-AGG-ID: 2UHi97AaNNiPUCdum41-Gg_1783441713
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-847a00bcbd0so5340927b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783441713; cv=none;
 d=google.com; s=arc-20260327;
 b=PxZRTiQOWHJnxVvf+OUS5OgGSEKKX5SO+f/+PsfuROoM+KVKRNEgRqOMLBVty3Wx/W
 dFtvHDawpauZGxGXtquAoh6S8+FoRxHYYGPk4nAk4q+sgtMqLcOMnYx620jchVvp3Un1
 qbvSz5YAJMwRiSqP39xQWa/ZCtylLHuZ3hYe3N/i1OT/Ngl4ovEaB3NKVHQyzSC5uzCV
 gWYNQh5tdZfrEkYgeuh5LTK28g3JhYN+PPzDJ3BZEdH5PBlSRmyiSiLVPoKdO6yqhPUw
 JNuPkBboa0M8EV5hw2AGBUYezXIEFQYAy3bT8PkDhO/qkmpZExQoTVQA1KUnF5TGkyc/
 1Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L0I/nI52MIs5GzVAFcrNJugmgh9WN9J8EKhjNI4DSRk=;
 fh=F0dgOhjWeNKKF4lOLX4pCfstdD7jzmYXfhMY8YO8m4s=;
 b=q2jigE/XRX4Q0ZO7Yu+OnSZWgkHk8WrV6N5bpvz52wG2Uzlpry6FDCMm5nHbZJbRFX
 6PGQY5jBw7Ynl7+8TldZGJUiMdRcf9Y/GLEwDswfKphH+WfHYmQLPe29ekXISV73KWwe
 ESFj92Ev4ETXL/uDHJby5NMXa0F/OHeVc6eQtOl7AtcIa6v9V2jyCcdJb45tImW8KMM9
 buzdV5UR6Skav1hm/Zaht7ErCopHcZoeQhxWYCSvIsmhTCvAW6rHM3wa9vFFOGQsPSH0
 F4n1zLf8RADNvBuhh1EpZDMHYaNhPgCiUi7N9EfosgYRdZwlB0I2enAtpOfOk5FiI+JS
 RBig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783441713; x=1784046513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L0I/nI52MIs5GzVAFcrNJugmgh9WN9J8EKhjNI4DSRk=;
 b=QPYfXCaf0lK0Cw29ozqDxjbOziE5UFACcDzfAgq2G+O+2WyEc4K4BEWSA5EMYdNKGn
 X2MyJuBgrtigQxIaIk5wZ7iNS387TJUCyXA18kMHCQOECV7v0YPp8Z2rnw0hPO6WkVrH
 99mbOCO5duqgWhRFUobMhnCgBYBT3wPJTkDWjcp+4sV8y7OASk5bR737qdrWXv0JWWt4
 f91bEEURy/Ls5MJD0Z3fqOWwVVwefgIbRzzyzwNL8xaRSg0LllPQPlYM8zx3OMvX8D+X
 lZ22FIj0OeYr/MAxyTwndTlX5wQgok14pSHAwZi8bhZMGy7E9y8zodGJ20FDXGoA6LTH
 pvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441713; x=1784046513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L0I/nI52MIs5GzVAFcrNJugmgh9WN9J8EKhjNI4DSRk=;
 b=GM/YR+PTcN7J7jo7O+0lX/6T0bL/a76lIEmuByJrmVz27p8Hu8P6utpeIrnXxVZ9UY
 n1gHH+zPAMqCE81o4aZGTVIQaK/in2Jwh1liIOujcNnX9M1AddkqG1rgmk4FCth6E/Uw
 AwrDs1tKi7RK866sedsYHNci5XC9DiTKWqHXNLrIkYfeZqCzwLlAE1JTa9Kl2XBgDwNK
 p578N7EOWN8wzG+VQ7irmT/4pUopP1GOR74MugVVppEY0GbZGA4aPI9jVTCdvP0ia62L
 pSHhROFNDYkvI0IuEpwUxOgBNK/fogXwCR2l3I/0UWVEeEUpOzcH4Istt97o0NdWI0LT
 t/EQ==
X-Gm-Message-State: AOJu0YwJaIuIk14MItOszJqx8IQgE0ZRMMiCxcTzgt2FPIRN2MfsCRLo
 5aUCMI2oUkubse+m6Yot+liOx8mf66//U+UCwz9mO2W3GEnL4hGSdXPeieyM05UOYR9AYcerCT8
 yZnR1mRjfay0vFDY0H5Hsie4VJVorHabdMES9ykw9sjtTLqfENeiFgv3RAOxEQElcXdQqvM0ZjG
 yyn7H/DmYTEf4V0gA+lSofq7gVJAwzN0U=
X-Gm-Gg: AfdE7ckvsQbOUZsuLR9WQ7S+IPRQAoXlBRE1YMwE9ALIXtGsDWjYxspy5LF9nJzezgk
 Q6yVtV/VD3VXJ7R8+oZ2nXKrYT5U8aYEBSlRIyXFKQuMq+PcKqRuDofK6tSa/AArw9tAPcu7IkO
 oIWePbir7XKjtbe8d/zlB1nhcL1efbARkxF0bZyzWAFizAiqv+wxf9bpcreT2is5d0Hw==
X-Received: by 2002:a05:6a00:2ea0:b0:842:48ae:1d6c with SMTP id
 d2e1a72fcca58-84826d46fcamr5492665b3a.24.1783441712550; 
 Tue, 07 Jul 2026 09:28:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea0:b0:842:48ae:1d6c with SMTP id
 d2e1a72fcca58-84826d46fcamr5492642b3a.24.1783441712043; Tue, 07 Jul 2026
 09:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260707105927.2776822-1-berrange@redhat.com>
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 7 Jul 2026 18:28:20 +0200
X-Gm-Features: AVVi8CdbQeTdMbGa-RL4v3S-pNQl4Kx156LewCahFLJDQWvIHk2Mx2kKLqVsFsA
Message-ID: <CAA8xKjVBfwt7fpRkUeDvpEewdBJEQQ7_a5pJwJMi=Y8WXHcpwg@mail.gmail.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 7, 2026 at 12:59=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
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

Should we explicitly call out devices like CXL and NVMe where the
boundary between virtualization and emulation is ambiguous and we've
historically triaged them as hardening (non-security) bugs?

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
> +

Reviewed-by: Mauro Matteo Cascella <mcascell@redhat.com>

>  Architecture
>  ------------
>
> --
> 2.55.0
>

--
Mauro Matteo Cascella
Red Hat Product Security


