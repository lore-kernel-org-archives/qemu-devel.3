Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B90EE20A4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLl3-0006wy-90; Fri, 06 Feb 2026 08:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1voLkZ-0006nW-LG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1voLkI-0004ue-49
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770383856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQYJv2yWI91YlCNUyKqKuCd3WL5Nk8ftwHnFon66cBg=;
 b=H8dNmTSnTmkZRa3nKXSGCA0UZlT55Jq9xhSsM4riQAPHJoEJRNh3gKEGsHKQmAVnNL9piH
 YGBap4BDwyY5RUxTFMsu6GCmLzQN6gPmyEO51SVfmhEMdl1z0dXzEQDWVk6IwxmAjIv9JQ
 SGriw0BtTRw+eKWjl8VOdW0zoNKQsQw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-zlE2oHyqMYugIrh4uwCjfA-1; Fri, 06 Feb 2026 08:12:27 -0500
X-MC-Unique: zlE2oHyqMYugIrh4uwCjfA-1
X-Mimecast-MFC-AGG-ID: zlE2oHyqMYugIrh4uwCjfA_1770383547
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso83937256d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770383547; cv=none;
 d=google.com; s=arc-20240605;
 b=VNR4CwxXK+GqW34869RfKEesCs8RjlI7tKEExdjESx6iaau6eq4jK9tcrq577EUdq7
 LI5gBV1oIw+5CnV7y1KO6Tgsl8iUGhaIEx2b4R0ZOj12/jE0nk1mwekB8W29Hn0MIo6T
 C718Zbkw2qSjBXtebovxqh3Rc4/FeKD5nvXQpis7HJ8k6E8U+EhGfIPUhE9gMeyyqXM4
 BliKpXACCDYbTXtNseH738iHWvgUMbKkSsA+xlcI4ng0Hj+xL4UaX3DIBrOPJ7lRERVr
 1KlvTl8HIkL2AqaqvJXvI0rtP8Rkomcld3r6iTiL2NeBPx4BG+ckLcVYz4GrE4hNRCiq
 BRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PQYJv2yWI91YlCNUyKqKuCd3WL5Nk8ftwHnFon66cBg=;
 fh=i8u6pLRXSPxqwZUsqTjARdFnZP0TTi/728pDqZ3O9Pk=;
 b=R2nvCMtHe+o3euXpW9uY4c7V038xtRY1Y6ciRgFksZ25+oUEyX/ye3+rrdepl9Skzm
 UJka7MgXyUl4VKn8GYyD9NUcnnSIKMN2x0gx2jOhFAcfZDXxgBTA8S1jm2n73mLDVA/y
 Z87hIpUUgLVjP1Q5zTM7xHmbpw4wm80SuCC5P22lbIltUYQ8W5IB9OzpDSYfEv35oq7C
 tM7lCY9JksGz3cjDtnL5LMICUU8vO+Ln9SQwmlYxGJKrXR7YRg9D8iY1zeG+WhNnBTR7
 /XclzjDCTtzYggBoyQDYg8ujVZygXK3IWs4mhFqczQX+pvwpgpmCUX6jr0oxstC7atoF
 4mkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770383547; x=1770988347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQYJv2yWI91YlCNUyKqKuCd3WL5Nk8ftwHnFon66cBg=;
 b=CXUfshYPIAjh7jIwMZx9Ku5gpV2DF6zMQlmpVvgp+zcKSXvjiboYNnSktd/LRpBUbT
 G7hnN7xTxSkJBfliZQt6PoiiyIeIKn9sHQbfOaUs03e7xCpTaCjY2HaSZzLjEzkeRger
 TmRFD7VLXTs+g9ipR4fFY6H3Ow3PnJ3sHbPzSHXAxvjoM5ZRnPqGnW08CI1XqQOR7DvH
 OStrs6w+TPXcqa7TVUMdCsGBJnIVkDBZbxZeRKFgprJY0Zds9ZrhkXrr1HQhEr8TrvNB
 7vT0kvHPn7v4RfUa8v4Z2C790KU6zDs7K5KK5ZitAvhQ/X2SzG4g1X0DVp/xc4V6zJ/D
 ceFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770383547; x=1770988347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQYJv2yWI91YlCNUyKqKuCd3WL5Nk8ftwHnFon66cBg=;
 b=rwZRN8MGMfRJl5R0Kn6KVqwH7VySVociVK/aDpbiLgRllSKVqUDe+yisVMNwC+VbLo
 mm7+S/yhjmb8msXKJ55LVutqOwohumV5iCcgwW9yUnLCfs+wHwi4ppy/CsGDN0mjEqeu
 MmqrWrZqb/1U+qTGLYtlnmLrgGc74mrnFOz5OxwOzQ6wuBvxEYbX+ngrqmt75h1T53aX
 7JnPwLlLFXDlukifREmTMdVh1NKVopAaQG35Gsb7fDswaFpn9RpKfLhULjs0GDZo0Vdz
 0dRUrZRKBOf7RB3k0kwHxPwJpna1bHD+m0iVfXmU/TjDK4WkuS6QS3ps0MrWKY+fETwW
 SMtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Lje0SYfuhWdKeaKRwY+cIWUfVKUvHXHwiRz+AJOLjfMnTUhX4oXB5inEPVEC1+7+3IpjoPe5WAma@nongnu.org
X-Gm-Message-State: AOJu0YwsJyUgcnesscNmaeNH7M/z5cjG7I6+UrQufmPyceUSAY8ug2fm
 cp7kogLOQ5in7iEwVzkwJpBj/g9V2VMS4mI3oqNZCxmcdPti/TyHfbOOTQCCzP1c8r88fAtSkSN
 sIS+xIfQVG6a1moH5zSwbK1mRjg9QjWarENQYSSI6ixETdcTpARiuTEzNsPnNK7vSqGwBml29X2
 105db5NOODJlxOWD01O31EO7TJcvwmQX0=
X-Gm-Gg: AZuq6aLjwf/qFsI1nVpcTe7/KsUOdHAzAo4qUITe8E6DEBzSPCj5DKgrGNtccmhR7qW
 fn7BnbVg9UyK1KbG9Z8reZRUcz0Ydz10rpP/+1ssLg7JJ50wK4xevfIpvoB4JOAfMIRw+9xaxPq
 q6eGz5CF7Ww4MEzu//8NzP7SMY071/Z7QtU4BvxUSJd+xwc9/OM1BjxBwlR/vimUa/Cq3srZkOa
 7RF24j28DJ1jdfZbaUzi4c48Uno
X-Received: by 2002:a05:6214:250b:b0:880:854:908f with SMTP id
 6a1803df08f44-8953c86e4camr37776806d6.38.1770383546906; 
 Fri, 06 Feb 2026 05:12:26 -0800 (PST)
X-Received: by 2002:a05:6214:250b:b0:880:854:908f with SMTP id
 6a1803df08f44-8953c86e4camr37776256d6.38.1770383546486; Fri, 06 Feb 2026
 05:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-28-anisinha@redhat.com>
 <aa5e9335115b452870118b1c43c95ddb40e353af.camel@infradead.org>
In-Reply-To: <aa5e9335115b452870118b1c43c95ddb40e353af.camel@infradead.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 6 Feb 2026 18:42:15 +0530
X-Gm-Features: AZwV_Qgku-RlBBKiMn2Ic-_YkmbVZuzp_tcnQXGOTJwpnVxyAve--nfkV314OXY
Message-ID: <CAK3XEhMJzbcTVL=1U6-yG2wxEL3Hd3N1cLPHtghaNHEa8QH7Tg@mail.gmail.com>
Subject: Re: [PATCH v3 27/33] kvm/xen_evtchn: add support for confidential
 guest reset
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, kraxel@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Jan 28, 2026 at 12:22=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>

> >
>
> I think 'kp' leaks in the error case there? And the next one in
> assign_kernel_eventfd().
>
> I don't much like duplicating the code which performs the ioctls.
> Couldn't you have a helper function which does that when given a
> 'struct kernel_ports', then invoke *that* from both places?
>
> Or even better, make use of the fact that we *already* have the ability
> to replay these for serialisation/deserialisation?
>
> But backing up a little more... if this is for rebooting guests,
> shouldn't we be wiping the event channel setup completely, like a soft
> reset? Do we preserve to do *any* of this? Are you sure you don't see a
> soft reset wiping it all away, either before or after this code runs?

Ah yes, good catch! I added the following assertions and they never
failed has I walked through the code with gdb:

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 7802fa68ae..3c882d85bb 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1241,6 +1241,9 @@ int xen_evtchn_soft_reset(void)
         kvm_update_msi_routes_all(NULL, true, 0, 0);
     }

+    assert(QLIST_EMPTY(&eventfd_list));
+    assert(QLIST_EMPTY(&kernel_port_list));
+
     return 0;
 }

I reverted this patch and it does not break my Xen functional test. So
it seems the soft reset calls
xen_evtchn_soft_reset() -> close_port() -> deassign_kernel_port() and
all ports are cleaned up, meaning they do not need preserving through
the reset.

I will drop this patch in the next spin-up.


