Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A29CC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2yt-00006X-2a; Fri, 14 Jun 2024 05:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8888f3976=graf@amazon.de>)
 id 1sI2ys-00006O-62
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:12:22 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8888f3976=graf@amazon.de>)
 id 1sI2yp-0003GR-OB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1718356340; x=1749892340;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SiTf+ZAGtksbP9IUFjI4/vwyVGtJeqNNi5uyBfmgcpk=;
 b=OkFRDzkr6Hbnuf+JbFXHJ2UfkONxTUyqhzjwUKuIjvthKazG+1ttDUNp
 uzHWS/dU9+hEza4IHWyt5HhCWZj8T86WBEWg2EEtWKTWQN/NMADa/IKns
 4fW8sfZiibPIPdtVAF+lxhZEYnHzKy43/vCLYsstbeVMH8/D1qYStkjjS U=;
X-IronPort-AV: E=Sophos;i="6.08,237,1712620800"; d="scan'208";a="660657158"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:12:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:5594]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525]
 with esmtp (Farcaster)
 id 89758d5c-5b7c-4079-afe7-fda527eb5f95; Fri, 14 Jun 2024 09:12:12 +0000 (UTC)
X-Farcaster-Flow-ID: 89758d5c-5b7c-4079-afe7-fda527eb5f95
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 09:12:11 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 14 Jun
 2024 09:12:08 +0000
Message-ID: <75e169b6-1c0f-4b16-b5ca-9d80a4f4fa9b@amazon.com>
Date: Fri, 14 Jun 2024 11:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] AWS Nitro Enclave emulation
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <pbonzini@redhat.com>,
 <slp@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>,
 <philmd@linaro.org>
References: <20240601162652.55643-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240601162652.55643-1-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=8888f3976=graf@amazon.de; helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Ck9uIDAxLjA2LjI0IDE4OjI2LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IFRoaXMgaXMgdjIg
c3VibWlzc2lvbiBmb3IgQVdTIE5pdHJvIEVuY2xhdmUgZW11bGF0aW9uIGluIFFFTVUuIHYxIGlz
IGF0Ogo+IGh0dHBzOi8vbWFpbC5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjQt
MDUvbXNnMDM1MjQuaHRtbAo+Cj4gQ2hhbmdlcyBpbiB2MjoKPiAgICAgIC0gbW92ZWQgZWlmLmMg
YW5kIGVpZi5oIGZpbGVzIGZyb20gaHcvaTM4NiB0byBody9jb3JlCj4KPiBIaSwKPgo+IEhvcGUg
ZXZlcnlvbmUgaXMgZG9pbmcgd2VsbC4gSSBhbSB3b3JraW5nIG9uIGFkZGluZyBBV1MgTml0cm8g
RW5jbGF2ZVsxXQo+IGVtdWxhdGlvbiBzdXBwb3J0IGluIFFFTVUuIEFsZXhhbmRlciBHcmFmIGlz
IG1lbnRvcmluZyBtZSBvbiB0aGlzIHdvcmsuIFRoaXMgaXMKPiBhIHBhdGNoIHNlcmllcyBhZGRp
bmcsIG5vdCB5ZXQgY29tcGxldGUsIGJ1dCB1c2VmdWwgZW11bGF0aW9uIHN1cHBvcnQgb2Ygbml0
cm8KPiBlbmNsYXZlcy4gSSBoYXZlIGEgZ2l0bGFiIGJyYW5jaCB3aGVyZSB5b3UgY2FuIHZpZXcg
dGhlIHBhdGNoZXMgaW4gdGhlIGdpdGxhYgo+IHdlYiBVSSBmb3IgZWFjaCBjb21taXQ6Cj4gaHR0
cHM6Ly9naXRsYWIuY29tL2RvcmpveTAzL3FlbXUvLS90cmVlL25pdHJvLWVuY2xhdmUtZW11bGF0
aW9uCj4KPiBBV1Mgbml0cm8gZW5jbGF2ZXMgaXMgYW4gQW1hem9uIEVDMlsyXSBmZWF0dXJlIHRo
YXQgYWxsb3dzIGNyZWF0aW5nIGlzb2xhdGVkCj4gZXhlY3V0aW9uIGVudmlyb25tZW50cywgY2Fs
bGVkIGVuY2xhdmVzLCBmcm9tIEFtYXpvbiBFQzIgaW5zdGFuY2VzLCB3aGljaCBhcmUKPiB1c2Vk
IGZvciBwcm9jZXNzaW5nIGhpZ2hseSBzZW5zaXRpdmUgZGF0YS4gRW5jbGF2ZXMgaGF2ZSBubyBw
ZXJzaXN0ZW50IHN0b3JhZ2UKPiBhbmQgbm8gZXh0ZXJuYWwgbmV0d29ya2luZy4gVGhlIGVuY2xh
dmUgVk1zIGFyZSBiYXNlZCBvbiBGaXJlY3JhY2tlciBtaWNyb3ZtCj4gYW5kIGhhdmUgYSB2aG9z
dC12c29jayBkZXZpY2UgZm9yIGNvbW11bmljYXRpb24gd2l0aCB0aGUgcGFyZW50IEVDMiBpbnN0
YW5jZQo+IHRoYXQgc3Bhd25lZCBpdCBhbmQgYSBOaXRybyBTZWN1cmUgTW9kdWxlIChOU00pIGRl
dmljZSBmb3IgY3J5cHRvZ3JhcGhpYwo+IGF0dGVzdGF0aW9uLiBUaGUgcGFyZW50IGluc3RhbmNl
IFZNIGFsd2F5cyBoYXMgQ0lEIDMgd2hpbGUgdGhlIGVuY2xhdmUgVk0gZ2V0cwo+IGEgZHluYW1p
YyBDSUQuIFRoZSBlbmNsYXZlIFZNcyBjYW4gY29tbXVuaWNhdGUgd2l0aCB0aGUgcGFyZW50IGlu
c3RhbmNlIG92ZXIKPiB2YXJpb3VzIHBvcnRzIHRvIENJRCAzLCBmb3IgZXhhbXBsZSwgdGhlIGlu
aXQgcHJvY2VzcyBpbnNpZGUgYW4gZW5jbGF2ZSBzZW5kcyBhCj4gaGVhcnRiZWF0IHRvIHBvcnQg
OTAwMCB1cG9uIGJvb3QsIGV4cGVjdGluZyBhIGhlYXJ0YmVhdCByZXBseSwgbGV0dGluZyB0aGUK
PiBwYXJlbnQgaW5zdGFuY2Uga25vdyB0aGF0IHRoZSBlbmNsYXZlIFZNIGhhcyBzdWNjZXNzZnVs
bHkgYm9vdGVkLgo+Cj4gIEZyb20gaW5zaWRlIGFuIEVDMiBpbnN0YW5jZSwgbml0cm8tY2xpWzNd
IGlzIHVzZWQgdG8gc3Bhd24gYW4gZW5jbGF2ZSBWTSB1c2luZwo+IGFuIEVJRiAoRW5jbGF2ZSBJ
bWFnZSBGb3JtYXQpWzRdIGZpbGUuIEVJRiBmaWxlcyBjYW4gYmUgYnVpbHQgdXNpbmcgbml0cm8t
Y2xpCj4gYXMgd2VsbC4gVGhlcmUgaXMgbm8gb2ZmaWNpYWwgRUlGIHNwZWNpZmljYXRpb24gYXBh
cnQgZnJvbSB0aGUgZ2l0aHViCj4gYXdzLW5pdHJvLWVuY2xhdmVzLWltYWdlLWZvcm1hdCByZXBv
c2l0b3J5WzRdLiBBbiBFSUYgZmlsZSBjb250YWlucyB0aGUga2VybmVsLAo+IGNtZGxpbmUgYW5k
IHJhbWRpc2socykgaW4gZGlmZmVyZW50IHNlY3Rpb25zIHdoaWNoIGFyZSB1c2VkIHRvIGJvb3Qg
dGhlIGVuY2xhdmUKPiBWTS4gWW91IGNhbiBsb29rIGF0IHRoZSBzdHJ1Y3RzIGluIGh3L2kzODYv
ZWlmLmMgZmlsZSBmb3IgbW9yZSBkZXRhaWxzIGFib3V0Cj4gdGhlIEVJRiBmaWxlIGZvcm1hdC4K
Pgo+IEFkZGluZyBuaXRybyBlbmNsYXZlIGVtdWxhdGlvbiBzdXBwb3J0IGluIFFFTVUgd2lsbCBt
YWtlIHRoZSBsaWZlIG9mIEFXUyBOaXRybwo+IEVuY2xhdmUgdXNlcnMgZWFzaWVyIGFzIHRoZXkg
d2lsbCBiZSBhYmxlIHRvIHRlc3QgdGhlaXIgRUlGIGltYWdlcyBsb2NhbGx5Cj4gd2l0aG91dCBo
YXZpbmcgdG8gcnVuIHJlYWwgbml0cm8gZW5jbGF2ZXMgd2hpY2ggY2FuIGJlIGRpZmZpY3VsdCBm
b3IgZGVidWdnaW5nCj4gZHVlIHRvIGl0cyByb290cyBpbiBzZWN1cml0eS4gVGhpcyB3aWxsIGFs
c28gbWFrZSBxdWljayBwcm90b3R5cGluZyBlYXNpZXIuCj4KPiBJbiBRRU1VLCB0aGUgbmV3IG5p
dHJvLWVuY2xhdmUgbWFjaGluZSB0eXBlIGlzIGltcGxlbWVudGVkIGJhc2VkIG9uIHRoZSBtaWNy
b3ZtCj4gbWFjaGluZSB0eXBlIHNpbWlsYXIgdG8gaG93IEFXUyBOaXRybyBFbmNsYXZlcyBhcmUg
YmFzZWQgb24gRmlyZWNyYWNrZXIgbWljcm92bS4KPiBUaGUgdmhvc3QtdnNvY2sgZGV2aWNlIHN1
cHBvcnQgaXMgYWxyZWFkeSBwYXJ0IG9mIHRoaXMgcGF0Y2ggc2VyaWVzIHNvIHRoYXQgdGhlCj4g
ZW5jbGF2ZSBWTSBjYW4gY29tbXVuaWNhdGUgdG8gQ0lEIDMgdXNpbmcgdnNvY2suIEEgbWFuZGF0
b3J5ICdndWVzdC1jaWQnCj4gbWFjaGluZSB0eXBlIG9wdGlvbiBpcyBuZWVkZWQgd2hpY2ggYmVj
b21lcyB0aGUgQ0lEIG9mIHRoZSBlbmNsYXZlIFZNLiBTb21lCj4gZG9jdW1lbnRhdGlvbiBmb3Ig
dGhlIG5ldyAnbml0cm8tZW5jbGF2ZScgbWFjaGluZSB0eXBlIGhhcyBhbHNvIGJlZW4gYWRkZWQu
IFRoZQo+IE5TTSBkZXZpY2Ugc3VwcG9ydCB3aWxsIGJlIGFkZGVkIGluIHRoZSBmdXR1cmUuCj4K
PiBUaGUgcGxhbiBpcyB0byBldmVudHVhbGx5IG1ha2UgdGhlIG5pdHJvIGVuY2xhdmUgZW11bGF0
aW9uIGluIFFFTVUgc3RhbmRhbG9uZQo+IGkuZS4sIHdpdGhvdXQgbmVlZGluZyB0byBydW4gYW5v
dGhlciBWTSB3aXRoIENJRCAzIHdpdGggcHJvcGVyIHZzb2NrCj4gY29tbXVuaWNhdGlvbiBzdXBw
b3J0LiBGb3IgdGhpcyB0byB3b3JrLCBvbmUgYXBwcm9hY2ggY291bGQgYmUgdG8gdGVhY2ggdGhl
Cj4gdmhvc3QtdnNvY2sgZHJpdmVyIGluIGtlcm5lbCB0byBmb3J3YXJkIENJRCAzIG1lc3NhZ2Vz
IHRvIGFub3RoZXIgQ0lECj4gKHNldCB0byBDSUQgMiBmb3IgaG9zdCkgc28gdGhhdCB1c2VycyBv
ZiB0aGUgbml0cm8tZW5jbGF2ZSBtYWNoaW5lIHR5cGUgY2FuCj4gcnVuIHRoZSBuZWNlc3Nhcnkg
dnNvY2sgc2VydmVyL2NsaWVudHMgaW4gdGhlIGhvc3QgbWFjaGluZSAoc29tZSBkZWZhdWx0cyBj
YW4KPiBiZSBpbXBsZW1lbnRlZCBpbiBRRU1VIGFzIHdlbGwsIGZvciBleGFtcGxlLCBzZW5kaW5n
IGEgcmVwbHkgdG8gdGhlIGhlYXJ0YmVhdCkKPiB3aGljaCB3aWxsIHJpZCB0aGVtIG9mIHRoZSBj
dW1iZXJzb21lIHdheSBvZiBydW5uaW5nIGFub3RoZXIgd2hvbGUgVk0gd2l0aCBDSUQKPiAzLiBU
aGlzIHdheSwgdXNlcnMgb2Ygbml0cm8tZW5jbGF2ZSBtYWNoaW5lIGluIFFFTVUsIGNvdWxkIHBv
dGVudGlhbGx5IGFsc28gcnVuCj4gbXVsdGlwbGUgZW5jbGF2ZXMgd2l0aCB0aGVpciBtZXNzYWdl
cyBmb3IgQ0lEIDMgZm9yd2FyZGVkIHRvIGRpZmZlcmVudCBDSURzCj4gd2hpY2gsIGluIFFFTVUg
c2lkZSwgY291bGQgdGhlbiBiZSBzcGVjaWZpZWQgdXNpbmcgYSBuZXcgbWFjaGluZSB0eXBlIG9w
dGlvbgo+IChwYXJlbnQtY2lkKSBpZiBpbXBsZW1lbnRlZC4gSSB3aWxsIGJlIHBvc3RpbmcgYW4g
ZW1haWwgdG8gdGhlIGxpbnV4Cj4gdmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0IGFib3V0IHRo
aXMgYXBwcm9hY2ggYXNraW5nIGZvciBmZWVkYmFjayBhbmQKPiBzdWdnZXN0aW9ucyBzb29uLgo+
Cj4gRm9yIGxvY2FsIHRlc3RpbmcgeW91IG5lZWQgdG8gZ2VuZXJhdGUgYSBoZWxsby5laWYgaW1h
Z2UgYnkgZmlyc3QgYnVpbGRpbmcKPiBuaXRyby1jbGkgbG9jYWxseVs1XS4gVGhlbiB5b3UgY2Fu
IHVzZSBuaXRyby1jbGkgdG8gYnVpbGQgYSBoZWxsby5laWYgaW1hZ2VbNl0uCj4KPiBZb3UgbmVl
ZCB0byBidWlsZCBxZW11LXN5c3RlbS14ODZfNjQgYWZ0ZXIgYXBwbHlpbmcgdGhlIHBhdGNoZXMg
YW5kIHRoZW4geW91Cj4gY2FuIHJ1biB0aGUgZm9sbG93aW5nIGNvbW1hbmQgdG8gYm9vdCBhIGhl
bGxvLmVpZiBpbWFnZSB1c2luZyB0aGUgbmV3Cj4gJ25pdHJvLWVuY2xhdmUnIG1hY2hpbmUgdHlw
ZSBvcHRpb24gaW4gUUVNVToKPgo+IHN1ZG8gLi9xZW11LXN5c3RlbS14ODZfNjQgLU0gbml0cm8t
ZW5jbGF2ZSxndWVzdC1jaWQ9OCAta2VybmVsIHBhdGgvdG8vaGVsbG8uZWlmIC1ub2dyYXBoaWMg
LW0gNEcgLS1lbmFibGUta3ZtIC1jcHUgaG9zdAo+Cj4gVGhlIGNvbW1hbmQgbmVlZHMgdG8gYmUg
cnVuIGFzIHN1ZG8gYmVjYXVzZSBmb3IgdGhlIHZob3N0LXZzb2NrIGRldmljZSB0byB3b3JrCj4g
UUVNVSBuZWVkcyB0byBiZSBhYmxlIHRvIG9wZW4gdmhvc3QgZGV2aWNlIGluIGhvc3QuCj4KPiBS
aWdodCBub3csIGlmIHlvdSBqdXN0IHJ1biB0aGUgbml0cm8tZW5jbGF2ZSBtYWNoaW5lLCB0aGUg
a2VybmVsIHBhbmljcyBiZWNhdXNlCj4gdGhlIGluaXQgcHJvY2VzcyBleGl0cyBhYm5vcm1hbGx5
IGJlY2F1c2UgaXQgY2Fubm90IGNvbm5lY3QgdG8gcG9ydCA5MDAwIHRvIENJRAo+IDMgdG8gc2Vu
ZCBpdHMgaGVhcnRiZWF0IG1lc3NhZ2UgKHRoZSBjb25uZWN0aW9uIHRpbWVzIG91dCksIHNvIGFu
b3RoZXIgVk0gd2l0aAo+IENJRCAzIHdpdGggcHJvcGVyIHZzb2NrIGNvbW11bmljYXRpb24gc3Vw
cG9ydCBtdXN0IGJlIHJ1biBmb3IgaXQgdG8gYmUgdXNlZnVsLgo+IEJ1dCB0aGlzIHJlc3RyaWN0
aW9uIGNhbiBiZSBsaWZ0ZWQgb25jZSB0aGUgYXBwcm9hY2ggYWJvdXQgZm9yd2FyZGluZyBDSUQg
Mwo+IG1lc3NhZ2VzIGlzIGltcGxlbWVudGVkIGlmIGl0IGdldHMgYWNjZXB0ZWQuCgoKUmV2aWV3
ZWQtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+CgpJJ20gaGFwcHkgdG8gc2Vl
IE5pdHJvIEVuY2xhdmVzIGd1ZXN0IHN1cHBvcnQgbWVyZ2VkIGV2ZW4gaWYgdGhlcmUgYXJlIApz
dGlsbCBzb21lIG9wZW4gaXRlbXMgbGVmdDogUmVsZWFzZSBlYXJseSwgcmVsZWFzZSBvZnRlbiA6
KS4gR2l2ZW4gdGhhdCAKdGhlIGZ1bmN0aW9uYWxpdHkgYXMgaXMgaXMgYWxyZWFkeSB1c2VmdWwg
Zm9yIGRlYnVnZ2luZywgSSB0aGluayBpdCAKbWFrZXMgc2Vuc2UgdG8gbWVyZ2UgdGhlc2UgcGF0
Y2hlcy4KCk1pY2hhZWwgLyBNYXJjZWwsIHdvdWxkIHRoaXMgZ28gdGhyb3VnaCB5b3VyIHRyZWU/
CgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENo
cmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJp
Y2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlE
OiBERSAzNjUgNTM4IDU5Nwo=


