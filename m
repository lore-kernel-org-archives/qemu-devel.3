Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B7CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sQz-0004Vs-M9; Thu, 09 Oct 2025 11:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6sQh-0004K3-LT
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:19:47 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6sQb-0001NI-RI
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:19:42 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d60528734so10759217b3.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760023173; x=1760627973; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZg4AF6rIh+C8il8WtkM5K9qNXhZ3A87/kzIWgW9rok=;
 b=zPXJSfHKfy+yycbzV0ymS1gWX292AiwjnszfuTaKS1YX6OFBnKxDPFicMmzfQ1wGwA
 vutzm2liKfinRY1nLLd0PmO0QMqTVaARJBktQv3Z/x41RrI5UCgcKV+Db+gjGC2wDdNf
 UuA0hireUEoDW0gojYYz91UHhAwXoXwqiPtyyiQz5wlMY+cHD2lyKIkLmFEABsfBOYm+
 D4eGa6ajF1wXOOOqOjDb7EWebvH0fFCNrd10JA5tZ/voy8zpPHmt3itoCyi1NOLytEvQ
 E27Qx1KuXYXXv4H09woyadf/Rghjt4tc3OCIGCv6PrSqqzUI64mC73P5YxN7IsIK4DBN
 hLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023173; x=1760627973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZg4AF6rIh+C8il8WtkM5K9qNXhZ3A87/kzIWgW9rok=;
 b=VulBevms5PXUGJF1k6UJQKmQPJDD/AuXvJyfjI6gXTu9ENFOsOP1k/CO9LcIHQZRWs
 NN8diMJeItQUUcAz3IB4OdQw5/+XV51Aq76rkZZqL0L48MarF1K3rxsKB2Y05aDccP36
 pYWkk9GZDsQaS038DSA4TYjz72PKgrbuycKGv+7tPw7bKdklJ+wCTvL9cIJXoXV4qKiG
 FvGs56BN9EtL/mYevG3f5P1ZFxHf/Zj7i9q1MdB4IPzATxOt0cXPlmkee6+uxpZI22Gj
 8ZWkdZD3f+H+hs0lpXBnVUsrDgI0ta7oMi334xmpmJ6DRpUz6036KC6R3Lh9MGJYU2qS
 DT0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiHAGp8UZWFnLaoUs2uKCzXKaprxd78VXCSkbdmE9n2acFd6qtt6+V80piDc1bTP8heuwRLEdlXMtv@nongnu.org
X-Gm-Message-State: AOJu0Yxgov9UR0gzszLN/2h+wHuTMXgicWPxk0h+Y/mFCE9ys9qQxK6P
 L/RpSstJPWKbg/h4PbT9nsCah6EBJzEC2olHBvLomh/sOrvKeyXj+N9vCRINscN0zpoBN+RX2A9
 o6GLDqEol08UfBwcqBYaIXtwgXboF4TIXozXkPxne6w==
X-Gm-Gg: ASbGncsEBUtOEmZDkcEhEXSYApQv4eqccfQU9q63S+nqYIBkhcj8LBp+8MGvZQjFJyh
 EerBxBup4d1+wgvTOV4amHZ8D7R7Nw4Th2oj8UUoJzXo+1J7ykumhjzUrsoVifefx/wTCr2pl9z
 38tv5N2O7cKYbl63HKuxGVXv8S4Dd3JX+ADDZPqKoj+aJ9dTZtqxsR/lIGUm4tzM02Ohldf+hSG
 Tp85aOvWEz9RuVr3PJWPmqRH22UB2SM1dpQhJI4eetuQzE=
X-Google-Smtp-Source: AGHT+IGmS7nTo+O/VdN+IQZ4G/SUWtNQDcbSp9xh4nxNSxQXQ8oOmNXga3efTJZqLYpk1plKAdOk1eQafehtsqf9KSI=
X-Received: by 2002:a53:c9c6:0:b0:636:1fd9:d64b with SMTP id
 956f58d0204a3-63ccb825212mr5677209d50.2.1760023172847; Thu, 09 Oct 2025
 08:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org>
 <20251009145125.6583a24a@fedora> <87wm54nmyt.fsf@pond.sub.org>
In-Reply-To: <87wm54nmyt.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Oct 2025 16:19:21 +0100
X-Gm-Features: AS18NWBQyNfXQcnxi4vPQTObzUW2InZV_ETHl2QjL9ahSGJnOXebjCpJ1lpn8BQ
Message-ID: <CAFEAcA9wa2_c5YYwYJRL-aZThujxYPt1mg3zy_YEBaQ_8cX3Xw@mail.gmail.com>
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, salil.mehta@opnsrc.net,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, mst@redhat.com, salil.mehta@huawei.com, maz@kernel.org, 
 jean-philippe@linaro.org, jonathan.cameron@huawei.com, lpieralisi@kernel.org, 
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com, 
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com, 
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org, 
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com, 
 linux@armlinux.org.uk, darren@os.amperecomputing.com, 
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, 
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com, 
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn, 
 shahuang@redhat.com, zhao1.liu@intel.com, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 9 Oct 2025 at 15:56, Markus Armbruster <armbru@redhat.com> wrote:
> qdev introspection (device-list-properties) is like QOM type
> introspection.  I'm not sure why it exists.

It exists because it is the older of the two interfaces:
device-list-properties was added in 2012, whereas
qom-list-properties was only added in 2018.

device-list-properties also does some device-specific
sanitization that may or may not be helpful: it won't
let you try it on an abstract base class, for instance,
and it won't list "legacy-" properties.

One problem you don't mention with QOM introspection is
that we have no marking for whether properties are intended
to be user-facing knobs, configurable things to be set
by other parts of QEMU, or purely details of the implementation.

thanks
-- PMM

