Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E4ECCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIPIj-0003NW-O9; Thu, 30 Apr 2026 07:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPIg-0003Jh-Or
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:11:22 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPIf-0004GR-83
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:11:22 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6530dd51ccaso614453d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777547480; cv=none;
 d=google.com; s=arc-20240605;
 b=TuesRjuf2I78rmHeB4eJdKNzrFs+E981rWlq8PJ8WKh+a4jOsEQtz392gZRdZb55v+
 J6Vlr51UmLNy25fDRQyVIpqRlI0id7k6hft2Q6QdgANNrsCCHR4kc/zox3P7vNR6iqPy
 OJ6NSYSmMrSXuC+NCV7i8fsMRLNU2PjJdL+Q0aV/1Ive6NE4GoM3yJaHbEOP9nNUYqah
 7APipdmBT01EzPbvNcHVcV54xQCbkaOV9Pq96kWh3UoAkmI3CQOm892e1263SS60nTXT
 nkP//0dega4GkI/EOuTHKWCKx4lAjHHZmvmLuOMuej44ckMScltgT3Zmy8feD+lJpwKr
 dxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jOBa2BwcZLSDUUpuDelqXcp1PkIGsEpcfuBTtZlPwHc=;
 fh=DehVJobEyf896gBUwn8EFFGyC0hB+XBXHHB5auR/uX4=;
 b=iVKoPu06s+DdRgk0Ig+kukcRlw/34zRk5IiuMQ4nOYKnoCME7GHOXgycOCJ+Lxyv8w
 PcC768dZfoewMibWqC4mhDAAQHLCf7kb7eLMpqqvfGL8+SCarmJ0ZSPsl3jNkbixT3EO
 zztYcO9mOjJ8VnwUrv8uy42mAnpErqfODMjCUYOhuiY3/g66y5j/WfVomwgnlUTfPIcR
 KW3ZyiaWkZjDZvHIKrLeDckzwJd21xiAcS1tpjuGrZO9gmc52D2pN587a5RblE7a4y3e
 bZNmU8Gp9ugLqZjRqDbfHD/7LeXdFINePImk2RgpMRTaf8qBtjiINvU96O92H9mnn0r/
 to3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777547480; x=1778152280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jOBa2BwcZLSDUUpuDelqXcp1PkIGsEpcfuBTtZlPwHc=;
 b=Vbv2wxZALkqS388XOW7n4cUU0i25tUYQlnpkWi5rH8TfCLDgevVJ4D2iPUdYVZ9bCK
 Kg1UfRwZw43ArZH8v5SXjPncKgQBRvCNYnaEtQNCcS2I2xe3GpxySEnA1/A4oMSgbE5K
 Ra58oSQDimP5M/PqzkChMlvMPcSKFKLecfS7DCbq/k3HRQ5oyQz2tnLH484oSy8DQHmE
 KmKUvC2lYtciOO1JD9pugJZGA8Fi3m36Ir1kfQaiF+RBbLVVrTcjKiOQrOo5jbDZfSBe
 HIYsZmBB+19fzTAYLe6qIejphJMT59OpyjOn2mf6FjDtR+nLX/xbBMsnDvehCTs15s5U
 XBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547480; x=1778152280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOBa2BwcZLSDUUpuDelqXcp1PkIGsEpcfuBTtZlPwHc=;
 b=hDIvyf7yD4+chJ+zGOmQwN8kfRlxsQrG/V2xcTaSpgizsFN+9K2pMppEhPBUJMTwqI
 AU9kkH77APv5d0OG5RmibT+qp8j9P/YmS5BSVDMvhg0lr8f+2Hjkr4OrsQoOpvHr02ZJ
 gQ8O9YzIG6i711CulIxQYROQl0voypB/WYn7t8ccP9EGQpx1uk/Vy68IcYR/DccmyqR8
 66NX0pG3WWTqc9agB+LbfjJNsjFBZUVkNH+SX6bENsuHv4evDMySZfc3xYWWvc31HefA
 9XL8w24AEWU3n7E52dTzaHIsiPFwqDjs2KAJ4Tu0VJ6R7/jlkTQVZC0FVTaNHEKOjTb5
 y6sA==
X-Gm-Message-State: AOJu0Yx0pB82zVkqVZguRJmahB9+k5doN+SbL9crQ4xeyc0N4ok1OTvu
 xL3BLo+1EWO/12A7SwGi5Y0E2aQ94o2aJhf5abL9TwS0PG4kw8k9KpQf799XL+XCNnAnUrbvm2A
 30UUr6kIk9uyOuLiDs/DPGAsjFFMt4QRng4bbAL5veA==
X-Gm-Gg: AeBDiet20HV+X2LQf726Be/hUkgVzhVbakTWfEAk1pV7fHLmTG0UHE6bfvzn0PEA/Y/
 8VczereVtBUJOf3nl8V5D0AmlsVpg9eyFfliSgHEFaavuGe7v00tkqMnlFhw674zUEwCp8P4+k5
 djFc2cx+vo09FYGHUhIpEl6vvBPJ6ktM3ZGDt2LOGcQLQLEHwL6Dg2C1/FSbrPC4xJK9VbXnXwi
 FAcglJsV9BB1xGDxitsd17dSWXR3Ot59tSr+uffrZyRrY3ToxleFCMfjo8GHq7171eugqK8vaqw
 y4EyITD4+vyOaPjGKsFkP9Mk2TcVU1yiVDEPf20zCBnxWya/OCGTnVHKRz2tYqNcGnWYMxrit49
 i1w==
X-Received: by 2002:a05:690e:1a49:b0:656:25e6:e127 with SMTP id
 956f58d0204a3-65c18aecfd3mr1354623d50.11.1777547479592; Thu, 30 Apr 2026
 04:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 12:11:08 +0100
X-Gm-Features: AVHnY4LsLZu729GJkA52_DmE-18Adk1BJNDMx-suWx3bdoGRDgmLnEvtUJWUsHQ
Message-ID: <CAFEAcA_8RUWYNSByA56uPd=CpvvF-vM2cwYcyLW85z6ZJXUoRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] FEAT_RME_GDI initial work
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 21 Apr 2026 at 15:22, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> Adds FEAT_RME_GDI, some extra cases to arm_granule_protection_check,
> and a very basic TCG test to check the prerequisites of FEAT_RME_GDI:
> FEAT_RME and FEAT_RME_GPC2.
>
> FEAT_RME_GDI is not enabled yet as no functional support has been
> added; it can easily be enabled in cpu_arm_set_rme in future.
>
> In the future we should correctly set bits in the fault address
> registers such as PFAR_EL2, but I don't see any apparent support for
> these in the existing GPT mechanism. Testing this also gets tricky as
> I think this would have to be done from EL3 (e.g. by modifying
> test_rme_virt.py)
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

(cover letters don't need signed-off-by tags, just fyi)


Applied to target-arm.next, thanks.

-- PMM

