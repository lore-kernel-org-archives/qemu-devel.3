Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B591C982C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 20:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgqYU-0004QS-6F; Fri, 16 Jan 2026 15:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vgqYN-0004Mq-Cq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 15:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vgqYL-0000qz-VB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 15:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768595776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=VhqNBEpSjSZl+gojJL0w08AGeWs815X0DHcl2UcEBnI=;
 b=Uxx6plEX3G/IgV0PfMvmhI4JgTnGsANOwt5CAXXL8I8x4ceeBK4Cww3SeQo3N32LxBzW1P
 yr0ELKKC8fIqiNf5bOgZUYoh8zrbc9q+Uj8RMZmqUN+DKE9N0+mznuFo9LjZz/EtxjF1rE
 +yxed43P0AOYl4d5cRwsw7E3yQvfmA0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Ly0Qa9XSO9e-hk3CS0M_Ow-1; Fri, 16 Jan 2026 15:36:14 -0500
X-MC-Unique: Ly0Qa9XSO9e-hk3CS0M_Ow-1
X-Mimecast-MFC-AGG-ID: Ly0Qa9XSO9e-hk3CS0M_Ow_1768595774
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-64651279fbdso3358039d50.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 12:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768595774; cv=none;
 d=google.com; s=arc-20240605;
 b=JOpqQ1wO8eJNaRdpuTwnN2ZHZGL/qM3g/6zV2Tb1R+53f3Xkwc6Ou/qfi7+0QV/kG0
 6BQxXBJYdKHQMIiTjlr47qGXEBO7cxS+3et2MxQDPtvWjXyduJ3McWlPV/vdj47fxX7h
 klqpaXbrZvPi9rPwfA6cm9BaiXzIr10KdTR2kHOtzWXvmrRsr+I8Rx1FIATBp4JCcGXy
 /EdgVab1/efs84F4kAc8XOm3Kv7P6qPhClIkxWx85dsNz93fE0IJ1TgpFlOLtNf2RSmJ
 8S1uH4IUKMNJ+qIFqtATgvOna4LLwiv7PFM52+lnj3cghugFwNiJiQOD/E64ocTwal2I
 8JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VhqNBEpSjSZl+gojJL0w08AGeWs815X0DHcl2UcEBnI=;
 fh=aT0F+qDMuOxyjl4mnTXt2GCmCxXR1GKyVcv3JlhwWW0=;
 b=NH9Y3vCxs+qgmUAnZp1dAQY7rM4Ys3gWATzZgDZFUpto6eSMFEmCN9dwXCo8y8/GoF
 BtZP8enEbxLgyI5FVl8fce0S6Wau2oNwPtgYZwqJ2mED151+uv1Ulz6pwJq23AprJS75
 uyCbLxzc9495AsYfMa3aRWweLJgz/3JQJCiqFiCSLJ+KflU+Ln8q8pXfEPile4Eg6ndk
 ElW4wKU3xeRCW2gNneh+zqmxlXmBuHQfj76zwwSHKw0+qWfKEPRyH5ry376eM/5kl96Y
 j8ZJ4BuPBuatXx4K1pGHyFpA+Bi0HLRDMsZ6QAKVaBwiSBNFddCeFUIdzrrlxnf4WzY8
 yO6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768595774; x=1769200574; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VhqNBEpSjSZl+gojJL0w08AGeWs815X0DHcl2UcEBnI=;
 b=cFXs1KARabyfH8sMjNB8WL4gnifUx8+cSxYclsFkKGwkjtlU96WpW1g2Gy1qT5uVa8
 mB75T3PFhnlwJdeOUCC/v+G4yepf10N910WlxyRnFVYVElRnZ9GralCzW3EOHyDuyswt
 bhuuhPTrjMM7vBQayiQUJVhKvoJeeOvby6KPTelilV3CPn1jv7pV7TZyrBGfZPnYodGT
 TWOESAos+1bYKLKgCUmT0aBMB3Sdf0191PhHHYs0as96mUm64YBPLN6WPllPZ8gH4DpK
 TAAuwARRaJ2bE2ZAvB17F7tMrO0GTvTCPpwXD5DQoz6ErxKV/ECDr+2P9hD4XHCsSlZB
 X3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768595774; x=1769200574;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhqNBEpSjSZl+gojJL0w08AGeWs815X0DHcl2UcEBnI=;
 b=Hxgv2te4fTF0vZ3/uN1ozdjdsC9bYleI+lL+Aq9+bfXxgFfeyTtMNaB5/7VsjRoQeq
 3n1dd0Ip0pR3I65caLtbIaQgw2vowpw/MnMMchamad2we4y2kHEDzlCfywfBmLFF1MDe
 YYtKGbiAaFWCTG1DxQbCHOSElDU+MEN31BnUEond7d+mbUIKTJH9tjhCtBzi0Mn/olRT
 QhSCAOQzAks0vZaOC/zoUKIaOJZPuqJQEWKqbRcQZax4l0qwMz22QQeXgTBdwMbzbcNi
 xUVVerPE37Eb6Nlb+3/kdKTIxjxWlqlyCvvpdxxAdHGSA0ZEntXiTkGfVnp7C1JYvqnS
 ujaQ==
X-Gm-Message-State: AOJu0Yy8llpSsS4M3ixgGI8TTd0NTuJnqAINjljiziYR8rZ7V5JuO0LM
 Mr/PXPn1lPu7tN44OsUO3XjEbzvhDot3cfb3MeI5fpHiUIW2jqp2GdsjXYf8G8eXAQy2miARWkc
 SdwVZyZq7Q8tg5qEFcGIIjsigDOehYA2avt2cj8X7G2XlGOT+mT238T2X8qN+RaK0n5UBZopL96
 a/pO/WFqYZ2f+Y47HV1GZgGHXhexA6/wU=
X-Gm-Gg: AY/fxX4KbntAu6nia+xM1rvObmEbzli+Us1VY730+SPvGDfwjNkBpvbJYZBSA7L8IrC
 XwA9sKtft5kUX0yZFggZD60adRteE5YauOp3eicBIpqvhFqS1KVtDl7V7U6Td972lZBU/0t/ZFf
 yGulr3KWk/bKYriP8FUBqW+wTry+9ToIDqmXhYQQ51pU3kZQFfu8asUNkosQF4Xgwwiszo3OjBd
 yFOm9c/obskvfe3I6SJqYRALg==
X-Received: by 2002:a05:690e:d8b:b0:640:ddf5:254f with SMTP id
 956f58d0204a3-649164f7753mr3154471d50.62.1768595774129; 
 Fri, 16 Jan 2026 12:36:14 -0800 (PST)
X-Received: by 2002:a05:690e:d8b:b0:640:ddf5:254f with SMTP id
 956f58d0204a3-649164f7753mr3154295d50.62.1768595768965; Fri, 16 Jan 2026
 12:36:08 -0800 (PST)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Fri, 16 Jan 2026 15:35:57 -0500
X-Gm-Features: AZwV_Qg48ZbN3cZughe_5HEFP6aW8Dn54g6soGi3jjPiIkn5qeSc5tsrGxHLcFk
Message-ID: <CAFn=p-YHkDpE62N_gn0MAqDaLfuOxrj-5jt-MUDTvE=1ZopC_g@mail.gmail.com>
Subject: migration-stress tests
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Heya folks:

I'm working on a series that removes the qemu.qmp package from the
qemu.git tree and notice that
tests/migration-stress/guestperf/engine.py makes use of the
QEMUMachine class (which depends on qemu.qmp) -- Can you please let me
know which test(s) utilize this code so I can ensure that there are no
disruptions to these tests after the pivot to utilizing an external
library?

If they aren't executed by "make check", could you please give me some
instructions for how they are normally run?

Thanks,
--js


