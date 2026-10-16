Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D14FCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgPf-0005ys-Qv; Fri, 16 Oct 2026 07:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xHgPV-0005yC-6k
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xHgPR-0004z3-Rq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792151252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yorKX3ATTGPCDo+w9cWJrHcgGJHEsTpVexqDjD620sM=;
 b=JLi8Bqc1F1sxsUJnLkff18lBwQSCmGoFV4qePIcSI2NRONK+wk79lZuEKAxZjUlu3XibJF
 AGD6kEdoQ9WmDYShAUxofVfWIAFCXY/PdgfiYKS8oCOf8AMJLCko+JPllHce4Zt9396ANx
 1ZO/UEpHJft1naYMqdWI2CjbL71YwlQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Pw0DP_iBMdCmMygNUfGrQw-1; Fri, 16 Oct 2026 11:47:27 +0000
X-MC-Unique: Pw0DP_iBMdCmMygNUfGrQw-1
X-Mimecast-MFC-AGG-ID: Pw0DP_iBMdCmMygNUfGrQw_1792151244
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1ad49096fso9717115e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792151244; x=1792756044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yorKX3ATTGPCDo+w9cWJrHcgGJHEsTpVexqDjD620sM=;
 b=qtYNKdG+05vlzXzrS7GAEqdV+HJzvYnzPpt/AVdwRiZZkoCJhNG/b9BzDvVavBTzsh
 sJH6t80qpGxbqUjeV1/caHn6EhB8rf/9dyF9cBL732/dXqfPaQYKHG7IaAU3Gcp7CH0g
 5a86NzVq11Hn5fT/CN4QfyFEnSDQtJAOnCUnQfPeAw95egkImRS5JZtZ9CahruJe5erN
 DpoQQ2wK8Ob91Juod3jaxnGCaA62GjJ+iUGXi5pKyJewPxH8Hxf8Zi4PgIj38iJ2M4ok
 Y0H2CbJnIsTj1AhmIml+qPyhKzvnICG0HRl2zNd28Vz7esMPKCy3tdJFjoqaYLjmv1xn
 duZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792151244; x=1792756044;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yorKX3ATTGPCDo+w9cWJrHcgGJHEsTpVexqDjD620sM=;
 b=OknhBq9RXgVZC2iluDCUC+NTjm7ObTQeu6begGRxkiZ9zLBGcwjH6HA0Z1/Z5FtA2y
 PDbhQQmih6IkTGaXwGmtMmCEuISeNkIIFbebGgJxdi3ygRJDtbrqg8Rgcjty1PQJNq86
 CpwirYrZRZlCBZVuUKCQ16HhYY/TJ2ZsLeDHQoZdv7WLxta6Fyfg3I+nUJh3wLepk47s
 yzj/kV8tl0EyTXE0MB24WexXpov/GOH/XZKnWFkuJwiAaFZ3DFeuDr2tSbbwvZ5VDNlj
 UoKFDb4eqFA4Eg7zBT7SxiGUXGTXHIaMEE+VdwbXRoP3sxX9lhdqKvViNT+p38WohIbZ
 s01A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxexRTX9FRBQQ5ZGD1YNyAEd4UgEANQc7bUWqq2O9xKxXvXtZCrKsrYojNAajPwt4xaJwlOLS8XJDWI@nongnu.org
X-Gm-Message-State: AFq9FYLAUJTiwRsBmgeCm4oy6q1NW3/G8bzf6pHeUAQn5N8TF8XBs5ud
 j2lo0Uc4j4av6MNBI05ibZg0Mm9RCWw95irclN0o/8ScyK6cBJLzy7BexKUCilvYiqVwNA1TTdB
 Uo+lRlDo9G+AF/ygnVGzgTQdmVwiFgxfUR+PlYOYEVWqBGLOX638OnsM1
X-Gm-Gg: AYBFou1I2JUZ4Evu1rb2qc2ZfZZ6VOJGKzusGxrdvTH9l/A2f5WjvCREV5w0DmV31jG
 rniQii3zn9YtHz8urGBIO24jstsHYkj5QDz/Tiv5Rv0Ff77Zso8XihyAXUEa8Gah31JBK8XAtL9
 WtcQf+2Je3r18FijN/4+qlHZkg9kxWFXB+nQUUjP77J/41V7l3EK8vlC2z4Fx9vqQFhk7Ct4TBp
 0DcACr9hbGWO1yoR6SMil5As8kcV/g6UWH665cHuV1rUSfIaa4Dz/BWp1rgINJiSeDkNxaz7ES2
 XhMv8qNJ/RzULiTcbXmHCv3sSTcQBl2r0nMu8fITRVb5ySPOpjcfh/dhb34hIihE4P/FEXwp
X-Received: by 2002:a7b:cb86:0:b0:4a1:a3b5:2022 with SMTP id
 5b1f17b1804b1-4a1c66be8acmr44457895e9.14.1792151243524; 
 Fri, 16 Oct 2026 04:47:23 -0700 (PDT)
X-Received: by 2002:a7b:cb86:0:b0:4a1:a3b5:2022 with SMTP id
 5b1f17b1804b1-4a1c66be8acmr44457295e9.14.1792151242798; 
 Fri, 16 Oct 2026 04:47:22 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a0dsm4686296f8f.47.2026.10.16.04.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 04:47:21 -0700 (PDT)
Message-ID: <c5fab461-2645-489e-ba72-5ee7b51a2507@redhat.com>
Date: Fri, 16 Oct 2026 13:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Cover OHCI endpoint type mismatches
To: Junjie Cao <junjie.cao@linux.dev>, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 philmd@oss.qualcomm.com, qemu-devel@nongnu.org, junjie.cao@intel.com
References: <20261016093011.521951-1-junjie.cao@linux.dev>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261016093011.521951-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/10/2026 11.30, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@intel.com>
> 
> Check guest-visible state for OHCI transfers whose ED type disagrees with
> the endpoint type. Successful control and isochronous transfers exercise
> the same endpoint paths, ruling out inactive endpoints or an idle schedule.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
> Depends-on: <20261001194756.3003085-1-peter.maydell@linaro.org>
> https://lore.kernel.org/qemu-devel/20261001194756.3003085-1-peter.maydell@linaro.org/
> 
> Based on origin/master a19f59a72d96 plus the above OHCI fix.
> Tested on x86_64-softmmu and i386-softmmu with usb-audio and -audiodev none.
> On x86_64, both mismatches fail on that master and pass with the
> prerequisite; the normal cases pass in both. All four cases pass together
> for three rounds on both targets with the fix. OHCI hotplug and
> UHCI/EHCI/xHCI tests also pass.
> These cases check transfer state, not the original USB_RET_ASYNC assert.

Thanks for taking care of supplying a test case for this scenario!

Some comments below...

...
> +static void test_ohci_transfer(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    OHCITransferTest t;
> +    unsigned int scenario = GPOINTER_TO_UINT(data);
> +    uint32_t head, td_flags, psw, frame, done;
> +    unsigned int i;
> +
> +    ohci_transfer_init(&t, obj, alloc);
> +    ohci_get_device_descriptor(&t);
> +    if (scenario == OHCI_TEST_CONTROL) {
> +        qpci_iounmap(t.pci, t.bar);
> +        guest_free(alloc, t.data);
> +        guest_free(alloc, t.desc);
> +        guest_free(alloc, t.hcca);
> +        return;
> +    }
> +    if (scenario == OHCI_TEST_ISO_TO_CONTROL) {
> +        const uint8_t setup[8] = { 0x80, 6, 0, 1, 0, 0, 18, 0 };
> +        uint32_t expected[] = { CTRL_SETUP_TD(&t) };
> +
> +        qtest_memwrite(t.qts, SETUP_BUF(&t), setup, 8);
> +        ohci_write_td(&t, CTRL_SETUP_TD(&t), TD_DP_SETUP,
> +                      SETUP_BUF(&t), CTRL_TAIL_TD(&t), SETUP_BUF(&t) + 7);
> +        ohci_write_ed(&t, CTRL_ED(&t), 64 << 16, CTRL_SETUP_TD(&t),
> +                      CTRL_TAIL_TD(&t));
> +        ohci_writel(&t, HC_COMMAND_STATUS, HC_CLF);
> +        ohci_step(&t);
> +        g_assert_cmpuint(TD_CC(qtest_readl(t.qts, CTRL_SETUP_TD(&t))), ==,
> +                         CC_NOERROR);
> +        ohci_drain_done(&t, expected, G_N_ELEMENTS(expected));
> +        ohci_periodic(&t, true, 0, true, 18);
> +    } else {
> +        ohci_enable_audio_stream(&t);
> +        if (scenario == OHCI_TEST_GENERAL_TO_ISO) {
> +            /* Prove this configured endpoint and periodic schedule work. */
> +            ohci_run_valid_iso(&t);
> +            g_assert_cmphex(qtest_readl(t.qts, t.hcca + 0x84), ==, 0);
> +            g_assert_cmphex(ohci_readl(&t, HC_DONE_HEAD), ==, 0);
> +            g_assert_cmphex(ohci_readl(&t, HC_INTERRUPT_STATUS) & HC_WD, ==,
> +                            0);
> +        }
> +        if (scenario != OHCI_TEST_GENERAL_TO_ISO) {

You check here scenario twice for OHCI_TEST_GENERAL_TO_ISO ... I think you 
could merge the two if-statements.

> +            ohci_periodic(&t, true, 1, false, 192);
> +        } else {
> +            ohci_periodic(&t, false, 1, false, 192);
> +        }
> +    }
> +
> +    frame = ohci_readl(&t, HC_FM_NUMBER) & 0xffff;
> +    done = qtest_readl(t.qts, t.hcca + 0x84);
> +    for (i = 0; i < 5; i++) {
> +        ohci_step(&t);
> +    }
> +    g_assert_cmpuint((ohci_readl(&t, HC_FM_NUMBER) - frame) & 0xffff, >=, 5);
> +    head = qtest_readl(t.qts, PERIODIC_ED(&t) + 8);
> +    td_flags = qtest_readl(t.qts, PERIODIC_TD(&t));
> +    if (scenario == OHCI_TEST_GENERAL_TO_ISO) {
> +        g_assert_cmphex(qtest_readl(t.qts, t.hcca + 0x84), ==, done);
> +        g_assert_cmphex(ohci_readl(&t, HC_DONE_HEAD), ==, 0);
> +        g_assert_cmphex(ohci_readl(&t, HC_INTERRUPT_STATUS) & HC_WD, ==, 0);
> +        g_assert_cmphex(head & ~15U, ==, PERIODIC_TD(&t));
> +        g_assert_cmphex(head & ED_HEAD_HALT, ==, 0);
> +        g_assert_cmpuint(TD_CC(td_flags), ==, CC_NOTACCESSED);
> +        g_assert_cmphex(qtest_readl(t.qts, PERIODIC_TD(&t) + 4), ==,
> +                        ISO_BUF(&t));
> +    } else {
> +        g_assert_cmphex(head & ~15U, ==, PERIODIC_TAIL(&t));
> +        /* The iTD CC does not report a packet-level STALL. */
> +        g_assert_cmpuint(TD_CC(td_flags), ==, CC_NOERROR);
> +        psw = qtest_readw(t.qts, PERIODIC_TD(&t) + 16);
> +        g_assert_cmpuint(psw >> 12, ==,
> +                         scenario == OHCI_TEST_ISO_TO_CONTROL ? CC_STALL :
> +                         CC_NOERROR);
> +        g_assert_cmpuint(psw & 0xfff, ==, 0);
> +        {
> +            uint32_t expected[] = { PERIODIC_TD(&t) };
> +
> +            ohci_drain_done(&t, expected, G_N_ELEMENTS(expected));
> +        }

Having a sub-block here for the expected[] declaration looks weird. Please 
move the declaration of the expected[] array to the beginning of the else-{} 
block instead.

> +    }
> +    qpci_iounmap(t.pci, t.bar);
> +    guest_free(alloc, t.data);
> +    guest_free(alloc, t.desc);
> +    guest_free(alloc, t.hcca);
> +}
> +
>   static void test_ohci_hotplug(void *obj, void *data, QGuestAllocator *alloc)
>   {
>       usb_test_hotplug(global_qtest, "ohci", "1", NULL);
> @@ -41,6 +432,7 @@ static void *ohci_pci_get_driver(void *obj, const char *interface)
>   static void *ohci_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
>   {
>       QOHCI_PCI *ohci_pci = g_new0(QOHCI_PCI, 1);
> +    qpci_device_init(&ohci_pci->dev, pci_bus, addr);
>       ohci_pci->obj.get_driver = ohci_pci_get_driver;
>   
>       return &ohci_pci->obj;
> @@ -62,7 +454,30 @@ libqos_init(ohci_pci_register_nodes);
>   
>   static void register_ohci_pci_test(void)
>   {
> +    QOSGraphTestOptions opts = {
> +        .edge.after_cmd_line = "-audiodev none,id=snd0 "
> +                               "-device usb-audio,audiodev=snd0,"
> +                               "bus=ohci.0,port=1",
> +    };
> +
>       qos_add_test("ohci_pci-test-hotplug", "pci-ohci", test_ohci_hotplug, NULL);
> +    if (strcmp(qtest_get_arch(), "i386") &&
> +        strcmp(qtest_get_arch(), "x86_64")) {
> +        return;
> +    }

Is there any special reason that you limit this to x86? Couldn't this be run 
on other targets as well (especially since OHCI is more common on non-x86 
targets)?

> +    if (!qtest_has_device("usb-audio")) {
> +        return;
> +    }
> +    opts.arg = GUINT_TO_POINTER(OHCI_TEST_CONTROL);
> +    qos_add_test("ohci_pci-control", "pci-ohci", test_ohci_transfer, &opts);
> +    opts.arg = GUINT_TO_POINTER(OHCI_TEST_ISO);
> +    qos_add_test("ohci_pci-iso", "pci-ohci", test_ohci_transfer, &opts);
> +    opts.arg = GUINT_TO_POINTER(OHCI_TEST_ISO_TO_CONTROL);
> +    qos_add_test("ohci_pci-iso-to-control", "pci-ohci", test_ohci_transfer,
> +                 &opts);
> +    opts.arg = GUINT_TO_POINTER(OHCI_TEST_GENERAL_TO_ISO);
> +    qos_add_test("ohci_pci-general-to-iso", "pci-ohci", test_ohci_transfer,
> +                 &opts);
>   }
  Thomas


