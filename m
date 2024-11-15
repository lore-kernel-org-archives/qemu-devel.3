Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FE2D68BC2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBxZF-0002uw-If; Fri, 15 Nov 2024 09:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha12@gmail.com>)
 id 1tBvfD-0006DK-FP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:43:03 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhenyzha12@gmail.com>)
 id 1tBvfB-0006k3-8i
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 07:43:02 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so424947a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731674579; x=1732279379; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPvJq7YEFWZ58WDq02jiBM8K9QCy2XEiYtQ4HddA7Yg=;
 b=NLYAzEue8Q0t13d2WmPBYb6aBNcuC6sHd8Ke5yf59LeQ9NE0V5y6CFuYzJd1cIeg7M
 V3RDiO6xik0UXEEz4pGeaew88USBrT9BFrEdRujFXTzINfMGtIj8BT0HGS3KLGBaU78q
 RGEitl8dVTN+yokZ0KR4cag2QGjHVQx2nAcXGY2ewNaIoobQpzcpvgwUu14uSduQFeib
 8Fau/86402IuwTicTWEgujvM4m9Evnl9x80sCjVZidzkHLPiIJhJJg6dk7QpaGza2UHV
 yowO2u5gw0SjV44YqiT5Dik1K8MW+UfwCxE/3kkqt7XMyDBOW/58K2t7aXZg2zdbxl1I
 ZbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731674579; x=1732279379;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cPvJq7YEFWZ58WDq02jiBM8K9QCy2XEiYtQ4HddA7Yg=;
 b=ojn6qhU1ShUED7/5Ur4635MbTBW/AYNwBHTSMIcnzXJABDoeGWthcI0qKLvcA8LbTY
 f3sDpwNZqUtpa7/p5jCRSCnjZkAArxhZCPrB5r4FBCFM2UYLkGKFYInxB4CYjgg4mxyQ
 WRhmTayrYDF5YkPyKqgZDQeSeP7pYUVbfHcYgVWipNWEZq/afEVEVX+f+o9RBj76T3ID
 qoVoMce0SoyER/KbX0tihW8ZDChHEgdZ5HAPdAbimCzCu4+6iN4Xw1gKmhvK4U/dcDXf
 VehrKMuL/P/JtCK2VD36Unyhv01UYIMWQjTFX3w/toWCXJ0uk+tW4mlBoPAHUjES5dr7
 5zvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgUb2VRgTpGoBMqlZ3l4uWGFRu34j7nmf50uLt3wcdotvM/SI53Qy9Seb5Cxz8PA6niGTWWM+TaRMF@nongnu.org
X-Gm-Message-State: AOJu0YzER+TicS7MstX3BfWguL1hsXihw04LuH1PMk2RLPmga0G5B61w
 /RQFuew2dNoLUiANmXiddZM3Dpi1XOxUQeV+L2QQwmS7Ik4szzfq
X-Google-Smtp-Source: AGHT+IH380LSTlu5PzdBSaZ7KkATEVxETE7izKeNtiLQ969wKtC2w1045LtuHzpWnmoHZJIxBpgojg==
X-Received: by 2002:a05:6a21:7915:b0:1d9:270a:947a with SMTP id
 adf61e73a8af0-1dc90bcb5ecmr2905532637.30.1731674578850; 
 Fri, 15 Nov 2024 04:42:58 -0800 (PST)
Received: from ?IPV6:2408:8207:5443:c921:90d9:99d3:13bd:a999?
 ([2408:8207:5443:c921:90d9:99d3:13bd:a999])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72476c8fc47sm1264082b3a.0.2024.11.15.04.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 04:42:58 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------xU06kpixFau0cg2kJlM0tdmA"
Message-ID: <e9392f4d-71a6-4909-bfb1-fc2d15e1ef96@gmail.com>
Date: Fri, 15 Nov 2024 20:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: ensure valid link status bits for downstream ports
To: Sebastian Ott <sebott@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, zhenyzha@redhat.com
References: <20241111123756.18393-1-sebott@redhat.com>
Content-Language: en-US
From: Zhenyu Zhang <zhenyzha12@gmail.com>
In-Reply-To: <20241111123756.18393-1-sebott@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhenyzha12@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 Nov 2024 09:45:00 -0500
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

This is a multi-part message in MIME format.
--------------xU06kpixFau0cg2kJlM0tdmA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/11/11 20:37, Sebastian Ott wrote:
> PCI hotplug for downstream endpoints on arm fails because Linux'
> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
>
>    pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>    pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>    pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
>
> There's 2 cases where LNKSTA isn't setup properly:
> * the downstream device has no express capability
> * max link width of the bridge is 0
>
> Fix these by making the LNKSTA modifications independent of each other.
>
> Signed-off-by: Sebastian Ott<sebott@redhat.com>
> ---
>   hw/pci/pcie.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0b455c8654..f714f4fb7c 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1109,20 +1109,20 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>           lnksta = target->config_read(target,
>                                        target->exp.exp_cap + PCI_EXP_LNKSTA,
>                                        sizeof(lnksta));
> -
> -        if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
> -            lnksta &= ~PCI_EXP_LNKSTA_NLW;
> -            lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
> -        }
> -
> -        if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
> -            lnksta &= ~PCI_EXP_LNKSTA_CLS;
> -            lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
> -        }
> +    }
> +    if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
> +        lnksta &= ~PCI_EXP_LNKSTA_NLW;
> +        lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
> +    }
> +    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
> +    }
> +    if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +        lnksta &= ~PCI_EXP_LNKSTA_CLS;
> +        lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> +    }
> +    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
>       }
>   
>       pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,

|[PATCH] pci: ensure valid link status bits for downstream ports

Test on aarch64 host(v9.2.0-rc0-1-gbde0d70333)
PCI hotplug for downstream endpoints on arm succeed
The test results are as expected.
|

|Tested-by: Zhenyu Zhang <zhenyzha@redhat.com> |

--------------xU06kpixFau0cg2kJlM0tdmA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024/11/11 20:37, Sebastian Ott
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20241111123756.18393-1-sebott@redhat.com">
      <pre wrap="" class="moz-quote-pre">PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Fix these by making the LNKSTA modifications independent of each other.

Signed-off-by: Sebastian Ott <a class="moz-txt-link-rfc2396E" href="mailto:sebott@redhat.com">&lt;sebott@redhat.com&gt;</a>
---
 hw/pci/pcie.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0b455c8654..f714f4fb7c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1109,20 +1109,20 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         lnksta = target-&gt;config_read(target,
                                      target-&gt;exp.exp_cap + PCI_EXP_LNKSTA,
                                      sizeof(lnksta));
-
-        if ((lnksta &amp; PCI_EXP_LNKSTA_NLW) &gt; (lnkcap &amp; PCI_EXP_LNKCAP_MLW)) {
-            lnksta &amp;= ~PCI_EXP_LNKSTA_NLW;
-            lnksta |= lnkcap &amp; PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta &amp; PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
-        }
-
-        if ((lnksta &amp; PCI_EXP_LNKSTA_CLS) &gt; (lnkcap &amp; PCI_EXP_LNKCAP_SLS)) {
-            lnksta &amp;= ~PCI_EXP_LNKSTA_CLS;
-            lnksta |= lnkcap &amp; PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta &amp; PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
-        }
+    }
+    if ((lnksta &amp; PCI_EXP_LNKSTA_NLW) &gt; (lnkcap &amp; PCI_EXP_LNKCAP_MLW)) {
+        lnksta &amp;= ~PCI_EXP_LNKSTA_NLW;
+        lnksta |= lnkcap &amp; PCI_EXP_LNKCAP_MLW;
+    }
+    if (!(lnksta &amp; PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+    if ((lnksta &amp; PCI_EXP_LNKSTA_CLS) &gt; (lnkcap &amp; PCI_EXP_LNKCAP_SLS)) {
+        lnksta &amp;= ~PCI_EXP_LNKSTA_CLS;
+        lnksta |= lnkcap &amp; PCI_EXP_LNKCAP_SLS;
+    }
+    if (!(lnksta &amp; PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
     }
 
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
</pre>
    </blockquote>
    <p><code>[PATCH] pci: ensure valid link status bits for downstream
        ports<br>
        <br>
        Test on aarch64 host(v9.2.0-rc0-1-gbde0d70333)<br>
        PCI hotplug for downstream endpoints on arm succeed<br>
        The test results are as expected.<br>
      </code></p>
    <pre><code>Tested-by: Zhenyu Zhang <a class="moz-txt-link-rfc2396E" href="mailto:zhenyzha@redhat.com">&lt;zhenyzha@redhat.com&gt;</a>

</code></pre>
  </body>
</html>

--------------xU06kpixFau0cg2kJlM0tdmA--

